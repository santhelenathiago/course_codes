#!/bin/bash
# Usage: grade dir_or_archive [grades.csv]
INFILE=$1
test -z "$INFILE" && INFILE="."
INFILE=$(realpath "$INFILE")
# grades.csv is optional
GRADES=""
test -z "$2" || GRADES=$(realpath "$2")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Absolute path to this script
THEPACK="${DIR}/$(basename "${BASH_SOURCE[0]}")"
STARTDIR=$(pwd)

# Split basename and extension
BASE=$(basename "$INFILE")
EXT=""
if [ ! -d "$INFILE" ]; then
  BASE=$(echo $(basename "$INFILE") | sed -E 's/^(.*)(\.(zip|tar\.(gz|bz2|xz)))$/\1/g')
  EXT=$(echo  $(basename "$INFILE") | sed -E 's/^(.*)(\.(zip|tar\.(gz|bz2|xz)))$/\2/g')
fi

# Setup working dir
rm -fr "/tmp/$BASE-test" || true
mkdir "/tmp/$BASE-test" || ( echo "Could not mkdir /tmp/$BASE-test"; exit 1 )
cd "/tmp/$BASE-test"

function cleanup () {
  cd "$STARTDIR"
  rm -fr "/tmp/$BASE-test"
  return 1 # helps with precedence
}

# Avoid messing up with the running user's home directory
# Not entirely safe, running as another user is recommended
export HOME=.

# Unpack the submission (or copy the dir)
if [ -z "$EXT" ]; then
  cp -r "$INFILE" . || cleanup || exit 1 
elif [ "$EXT" = ".zip" ]; then
  unzip    "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.gz" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.bz2" ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.xz" ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
else
  echo "Unknown extension $EXT"; cleanup; exit 1
fi

# There must be exactly one top-level dir inside the submission
NDIRS=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
test "$NDIRS" -gt 1 && \
  echo "Malformed archive! Expected exactly one directory" && exit 1
test  "$NDIRS" -eq 0  -a  "$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)" -eq 0  && \
  echo "Empty archive!"
if [ "$NDIRS" -eq 1 ]; then
  cd "$(find . -mindepth 1 -maxdepth 1 -type d)"
fi

# Unpack the testbench and grade
tail -n +$(($(grep -ahn  '^__TESTBENCH_MARKER__' "$THEPACK" | cut -f1 -d:) +1)) "$THEPACK" | tar zx
cd testbench || cleanup || exit 1
./validate.sh || cleanup || exit 1
if [ -n "$GRADES" ]; then
  echo "$BASE$EXT,$(cat grade)" >> "$GRADES"
fi
echo -e "Grade for $BASE$EXT: $(cat grade)"

cleanup || true

exit 0

__TESTBENCH_MARKER__
� f\k[ �Z[s�V�}��4R��K�!K���Ʌ%�v�̉t�,�Ց��Ӈ����/}����I�s�]�n��������Q���9m\�ՠ	�X[����Z��������j{}mmc�v��z���z,� �1��ć�'߽�C�P�s���g��ŧ�A^�t�e��vf��jk�������O��E��������G��^�}���7��خ�\27�/'��Y�h,|6�8��H@q�%ܓ�G�%�8��v�+F"p��H�o8�ٞ�O"Q��8Y�i�'.��8tC�B+^����� Q�	���#oȱ5��A,lbW�-��,�־�q	I(�����b�p�x��<�<=�N�2qA�F>��8�!d&hy�9�<	��S�"�^"1�m�z��	�B����8u����[��6��D�A{�lpw�G�u��a=�\���>��x�A��ٽ��S�Ȫa�������;�$�n��b?t���Lz�,�7M�YĽ3��(
��84�=��=ڬ�ρ���Vl�x�@*e0�%'�ΡK��+!��5c�sȺ�����h���\/�*�S�ċ0y����5&X@���u�qW�_|y��#��D����4�+vX��� �Ej��a�a��I	�3< -nĢ��>Yׇm�&'���	<��ّ��S��D�e�����Kd�T"�M^3�P��C�"
��A�D&���rPC$H��Q5� 6����#V5a��{,�Hv��q#H�C+M��o�{��̌C�6!G>�U4��M�MܒH�Q�gD�70���z{�\�E$0Y#=Q��Ȁڻdr
���d��M|r�<,*�fK��U��WG��6
p�����(N��r?�T՛s�����G�<0
��X(��W]6H�c:�ɓ5�ӷ�0�Ow�Zz��4Sq�d��'B)�~(g�G���'S�b��5.W��m�տ&+ԿQ��2v7�V��Y��^�>�C�5.�cV�����?G�'�)���L�xaBP������C�6�?��������ei>$�MOTM����2w�KϤ�@�Q2����)3��	����t#)+�I��z(|� ��5٘G���X`��Su �9l�)�<d+�_S����S�o����8[��\ay����	�	����BiLq�H��j�����r{sv�BqU�{?#�Jd#�ك3U��DB:B)���������$!�M���G�Q&�d
k�,4KK�t��ѣ/n��nV��	�"@�dF�]�b�`=��e�e��#.ю�`�lE/S!<s��Sv��G<w)i(v�FF@�B�9��|��B�$�d�H��y�Q����c�Wb�8��·54�0t�"��)���JF�s�������dE��?��E�G:�e�U���鐲�?�ݾw��;K������u�;Wr���	�[ȹM&9b3����)r�;K�/U��%�I8\L,�X���p��;t^��Z��
��j������av���r4�������K�s���Zg������R����<5�Q~�A0T-�n6���G�jꙈBC8�!k�[l�<��h��ϖ��ҡn�gm+���d�����S�)����p�Iu&5E3a]�&�Y��{�-��u���F��|��u��!�v#kV�,c�p�p�X~��E�
�b�j_cOn,�̧62Qm	Ո%t:q`^'�)<5$ʱ�9R3Ԝ�-�sԖ6Y�Y���j�GH�)���>�.�(8�\p�b:3�t)��,GI`�9b�Z��\��&�9�=�ޮg��t�z���R�
�Y����:��vP���	�������"$�s��; [���h�D;z�}�}��,?@���C�ܓ+&
rONơ������3|��e���	c�V�M���\9*xH���U���K;�0W��b�����kڤRx��V�o�EK
��E|�S�s��g)�˖e[���e�߾w0��O��m�X��XE��J�Z�bU��Ibtj-VG߳���7��{C��j�q�{���j���&~?'�{~�ܺ������IY�x��I�)|PfkX�T��b�)~+�%=���r��B��Uʲ��O�g##�KV�$S��?}�px\pEz�+���P>U`�nk��hjo~�˭A^��Z��(Pj�9�~L���ׄ�T�O��|J]^���N;ñ��O�����]�lB����Z�,�[��BfQ��p���?�X������iẽ�8�#�6/$�Ù�i{�E��P�)E� �V]	���9�2�aלFq/P��{�6ej����pގ�ݲ�^^�l��&J�n>��̒���5f�� ��6Ō�\�����;��O�y���)���fL� y���]���)�P�P��StYDp��S%���^��Ð޳��`���4�����~���[� z[����!�f/P�7��:�~ݲ��8t�oQQ���������ew��w0��V�y���u��޸N�� �'��0��Wh��� j0��_�}��&r��?�7O�s��&B������Q~2��͉''�7j��Y���ٳ�Ê�e5z���޲q���sg,=������N�Obd=Y[nϦ���&jz�0�la�#�+z �X�C�l��Hw�d�Y�Y3؅o*�+8�~�I�S�VG	[��W7zv{����|r�u��(�Л5z�O�n��¿�\)R;�ɫ*@�ճ�k�k�&׭9��傋dɍ�t�A�eU������Y$8�H{�Z�Y��Z� �6+c9�s���qac�^��q|\-������p2C������^@}�;�Mϳ�P��tҝ�7z�G��J����bv��l�>�ļ�:�XM�\�c�>�0h8�GaV�,]KU��p�~�J2��B��{3QR��G���O:�'��zx��>��\ĝ�]ĝM+����^���.Wg�@zf~t�l:U�ųXQ
���3�yԳ��p��(,l�0��tqŸ����u=I���}�_z�ON��o�:���Osc���Q�o���������n�Ա95j�"�����'�^	�b�&���j}A�A�A����y�-�;a�[��	+����	���87�����],�>i�*5l��4��4�:5
�ɚ6�)�@���Io3�L�(�E�oVv�;�T/B�M�� W�N��X�����������rƌ[�=�{�i3!s�ړ2�u+�lݹ�����PZ?�����Jp���, {���x��l��R�}ո�`��C}S�R�V���5o/�/3_	%�PB	%�PB	%�PB	%�PB	%�PB	%�PB	%�PB	%�PB	%�PB	%�P��{oh P  