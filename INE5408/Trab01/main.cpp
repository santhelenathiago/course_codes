// Copyright 2018 Thiago Sant' Helena

#include <iostream>
#include <string>
#include <cassert>
#include <vector>
#include "libs_src/XMLObject.h"

void flood_fill(int index, int i, int j,
                const std::vector<std::vector<char>>& mat,
                std::vector<std::vector<int>>* aux) {
    if (mat[i][j] == '0') {
        return;
    }
    if (aux->at(i).at(j) == index) {
        return;
    }

    aux->at(i).at(j) = index;

    if (j > 0)
        flood_fill(index, i, j-1, mat, aux);

    if (j < mat[i].size()-1)
        flood_fill(index, i, j+1, mat, aux);

    if (i > 0)
        flood_fill(index, i-1, j, mat, aux);

    if (i < mat.size()-1)
        flood_fill(index, i+1, j, mat, aux);
}

int main(int argc, char** argv) {
    XMLObject xml_obj("dataset01.xml");

    // if (xml_obj.is_opened()) {
    //     std::cout << "O xml foi validado corretamente!" << std::endl;
    // } else {
    //     std::cout << "O xml não é válido!" << std::endl;
    // }

    if (!xml_obj.is_opened()) {
        std::cout<< "error" << std::endl;
    }

    // For debuging
    // xml_obj.print_data();

    auto data = xml_obj.data();

    std::vector<int> obj_count;

    std::vector<std::vector<int>> aux;

    for (auto mat : data) {
        // Init aux matrix will all 0 elements
        aux.clear();
        for (int j = 0; j < mat.size(); j ++) {
            std::vector<int> tmp;
            for (int k = 0; k <  mat[j].size(); k++) {
                tmp.push_back(0);
            }
            aux.push_back(tmp);
        }


        assert(mat.size() == aux.size());
        assert(mat[1].size() == aux[1].size());

        // Var to count objects
        int count = 0;

        // Iterate over entire matrix
        for (int i = 0; i < mat.size(); i++) {
            for (int j = 0; j < mat[0].size(); j++) {
                if (aux[i][j] == 0 && mat[i][j] == '1') {
                    count++;
                    flood_fill(count, i, j, mat, &aux);
                }
            }
        }

        // Put count on count-list
        obj_count.push_back(count);

        // Iterate over entire matrix
        // for (int i = 0; i < aux.size(); i++) {
        //     for (int j = 0; j < aux[0].size(); j++) {
        //         std::cout << aux[i][j];
        //     }
        //     std::cout << std::endl;
        // }
        // std::cout << std::endl;
    }

    auto names = xml_obj.names();
    for (int i = 0; i < obj_count.size(); i++)
        std::cout << names[i] << " " <<  obj_count[i] << std::endl;
}