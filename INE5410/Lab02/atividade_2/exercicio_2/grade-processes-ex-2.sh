#!/bin/bash
# Usage: grade dir_or_archive [output]

# Ensure realpath 
realpath . &>/dev/null
HAD_REALPATH=$(test "$?" -eq 127 && echo no || echo yes)
if [ "$HAD_REALPATH" = "no" ]; then
  cat > /tmp/realpath-grade.c <<EOF
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char** argv) {
  char* path = argv[1];
  char result[8192];
  memset(result, 0, 8192);

  if (argc == 1) {
      printf("Usage: %s path\n", argv[0]);
      return 2;
  }
  
  if (realpath(path, result)) {
    printf("%s\n", result);
    return 0;
  } else {
    printf("%s\n", argv[1]);
    return 1;
  }
}
EOF
  cc -o /tmp/realpath-grade /tmp/realpath-grade.c
  function realpath () {
    /tmp/realpath-grade $@
  }
fi

INFILE=$1
if [ -z "$INFILE" ]; then
  CWD_KBS=$(du -d 0 . | cut -f 1)
  if [ -n "$CWD_KBS" -a "$CWD_KBS" -gt 20000 ]; then
    echo "Chamado sem argumentos."\
         "Supus que \".\" deve ser avaliado, mas esse diretório é muito grande!"\
         "Se realmente deseja avaliar \".\", execute $0 ."
    exit 1
  fi
fi
test -z "$INFILE" && INFILE="."
INFILE=$(realpath "$INFILE")
# grades.csv is optional
OUTPUT=""
test -z "$2" || OUTPUT=$(realpath "$2")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Absolute path to this script
THEPACK="${DIR}/$(basename "${BASH_SOURCE[0]}")"
STARTDIR=$(pwd)

# Split basename and extension
BASE=$(basename "$INFILE")
EXT=""
if [ ! -d "$INFILE" ]; then
  BASE=$(echo $(basename "$INFILE") | sed -E 's/^(.*)(\.(c|zip|(tar\.)?(gz|bz2|xz)))$/\1/g')
  EXT=$(echo  $(basename "$INFILE") | sed -E 's/^(.*)(\.(c|zip|(tar\.)?(gz|bz2|xz)))$/\2/g')
fi

# Setup working dir
rm -fr "/tmp/$BASE-test" || true
mkdir "/tmp/$BASE-test" || ( echo "Could not mkdir /tmp/$BASE-test"; exit 1 )
UNPACK_ROOT="/tmp/$BASE-test"
cd "$UNPACK_ROOT"

function cleanup () {
  test -n "$1" && echo "$1"
  cd "$STARTDIR"
  rm -fr "/tmp/$BASE-test"
  test "$HAD_REALPATH" = "yes" || rm /tmp/realpath-grade* &>/dev/null
  return 1 # helps with precedence
}

# Avoid messing up with the running user's home directory
# Not entirely safe, running as another user is recommended
export HOME=.

# Check if file is a tar archive
ISTAR=no
if [ ! -d "$INFILE" ]; then
  ISTAR=$( (tar tf "$INFILE" &> /dev/null && echo yes) || echo no )
fi

# Unpack the submission (or copy the dir)
if [ -d "$INFILE" ]; then
  cp -r "$INFILE" . || cleanup || exit 1 
elif [ "$EXT" = ".c" ]; then
  echo "Corrigindo um único arquivo .c. O recomendado é corrigir uma pasta ou  arquivo .tar.{gz,bz2,xz}, zip, como enviado ao moodle"
  mkdir c-files || cleanup || exit 1
  cp "$INFILE" c-files/ ||  cleanup || exit 1
elif [ "$EXT" = ".zip" ]; then
  unzip "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.gz" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.bz2" ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.xz" ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".gz" -a "$ISTAR" = "yes" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".gz" -a "$ISTAR" = "no" ]; then
  gzip -cdk "$INFILE" > "$BASE" || cleanup || exit 1
elif [ "$EXT" = ".bz2" -a "$ISTAR" = "yes"  ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".bz2" -a "$ISTAR" = "no" ]; then
  bzip2 -cdk "$INFILE" > "$BASE" || cleanup || exit 1
elif [ "$EXT" = ".xz" -a "$ISTAR" = "yes"  ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".xz" -a "$ISTAR" = "no" ]; then
  xz -cdk "$INFILE" > "$BASE" || cleanup || exit 1
else
  echo "Unknown extension $EXT"; cleanup; exit 1
fi

# There must be exactly one top-level dir inside the submission
# As a fallback, if there is no directory, will work directly on 
# tmp/$BASE-test, but in this case there must be files! 
NDIRS=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
test "$NDIRS" -lt 2 || \
  cleanup "Malformed archive! Expected exactly one directory, found $NDIRS" || exit 1
test  "$NDIRS" -eq  1 -o  "$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)" -gt 0  || \
  cleanup "Empty archive!" || exit 1
if [ "$NDIRS" -eq 1 ]; then #only cd if there is a dir
  cd "$(find . -mindepth 1 -maxdepth 1 -type d)"
fi

# Unpack the testbench
tail -n +$(($(grep -ahn  '^__TESTBENCH_MARKER__' "$THEPACK" | cut -f1 -d:) +1)) "$THEPACK" | tar zx
cd testbench || cleanup || exit 1

# Deploy additional binaries so that validate.sh can use them
test "$HAD_REALPATH" = "yes" || cp /tmp/realpath-grade "tools/realpath"
export PATH="$PATH:$(realpath "tools")"

# Run validate
(./validate.sh 2>&1 | tee validate.log) || cleanup || exit 1

# Write output file
if [ -n "$OUTPUT" ]; then
  #write grade
  echo "@@@###grade:" > result
  cat grade >> result || cleanup || exit 1
  #write feedback, falling back to validate.log
  echo "@@@###feedback:" >> result
  (test -f feedback && cat feedback >> result) || \
    (test -f validate.log && cat validate.log >> result) || \
    cleanup "No feedback file!" || exit 1
  #Copy result to output
  test ! -d "$OUTPUT" || cleanup "$OUTPUT is a directory!" || exit 1
  rm -f "$OUTPUT"
  cp result "$OUTPUT"
fi

echo -e "Grade for $BASE$EXT: $(cat grade)"

cleanup || true

exit 0

__TESTBENCH_MARKER__
� _z}[ �Y[S�J�Y���`䋌Ce.'�j	�r�ݪ�R�4�U�Gr����S�p�<�i���l{f$Y�e$�j+�/����{�6rD���v���è���l�k}�Y�_SZ�7�Mk�Yol.���Fmc	�?Ҙ�0"���on8�o���S���������FsC��������P�q��c��onN��iYKP�~��O��+��Kׯ^���u�ZF];h��o�����ɻ�ѐ?.�OO^�����>�e���[FS�����>���g�X������i]��F)��2���0 �(�!4��0o�d��ˀ�+�a>��.��0�ԨO}D�>���p���z���hh8���`�b�U*�b���g / `�	x
����^��R0I�Ղ��ŕ�)���].���FP�6�Z��ă���q��Js@��G�-��1��Ϟm��������A����;^�(����3��7���S���C�#�8�ƞG�m�������b��:�ľ�MR���"�}Hzt��Dy���D��	h{�WÀY��G}�ߜc݀s��I�!>���X֣�i3?�~�2��l��_�\��R/�*b��Xl����������	Oy��]���l�m��W�ze�Ko"MTހFq���o�q=θf�J)�Z�\N��B���[� �� �������$�Z,7S�2�M��.��+��,q_4-p�S1�����w����g�M�6nF���'%]�cp>h��yc�bK���f�y�̍	f�}�XC?��Df�n�zYO�󯳬� ;;3�
Ǥ0&u=\$�����y �Q>y"-���ل����QE>�z�!��0p��g��*V�L_��^�Y����>��L*r)]�b�@��fLr����3S=�Y>�aR�QJ����V���6��ճJ�V��V�:�L
M[\��k��h%�g����ը=�����3���&���@���\<�̬��ޕ$��xPʸ_�"f����/̿N�=��������j+���O��Ѐ�\�!�X������� bdY�R���(�a;�4yL۩w$4��߲(�����J�1�):�B�,2X�Vr��A~����ۭ1��u�ΛS�N���*�F�x��U�;Te���<�-'���/���5h4<�?*MZ�(�(����i�^3�_�%��A�B��l���<�M"�4��P�ҡO��؎�=��8��$4�c�%�������j=w�B�dv2vq���LE��=6Cv>���v����j������X>o��Vs��)�ċ0��nɽD\ ��>X����ֵ�j����FxE� �P �����{���a@� W�����ɳ5��cLm�?b��JV<Y�͂�x`��"�� -�+R�_���xu>Pv���F7��k��� ��YQ:D��P�1OF��S3㦥���Y�GY\¢���l0�d��L���2���|�)�E�'>�4e3��*��Ԝ�sc[|8�&ȓ�LcG��#���*/���Wo��] ��`?O�]�u1��40��E�=C���%����9� #QIR@47w�w�U]����^�.��0�>^l�1� �y<�˸�E|=��\����=��t��
��?p�e-���vR ��b�ʏ����RI<����I�t�^�Ka丬,���}l"���eH�k��4�N�HM�Bꭣ!
F�#6��6�(P���萀A�{��8kZ��q�)<�(K B�C?_�� ��ؽf�z��y�I��w\kdg��n$�xl=��2���.��^������C&��
���Hȿ&�4q�0�/>����67F.�>�7]����������{(��X%:�1�6C�e��
�X,Gd����l�ʊ�FuV�N���5�^���uLt��E݁/B���W|N9rpC�.&#����wt��?0�� ���"^�U�<ar��^=N���vx\�+4TXW({�|8�4ә��@|tK��Թj��T[��O�����+�|g�Q�C;��Y����1��z�íot��p��S��í�;����~t����:]�d��s�~6�𴈛=�E�H9yݝ�Z��6fm�c]�0Εӊ��gYIc���������0���%�,�����Ir�����M �|��)��D<�8��̟�L���DU/8��^(�M�`�If�1X7��mCg'�#��d.�*g>�8oɩCʓsT���v:$j��˾<��_f������4�mȎ����
V�������C��09Q��y�ܝ �ʔ��tQ腋E�޲ʒ�v?Ur�=��E���N�>��	<��+�5_�"E�)R�H�"E�)R�H�"E�)R�H�"E�)R�H�"E�)R��� ��� P  