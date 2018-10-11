// Copyright 2018 Thiago Sant' Helena

#include "XMLObject.h"


XMLObject::XMLObject(const std::string& input_file) :
    opened{false} {
    this->stream.open(input_file);


    if (!this->validate_xml()) {
        return;
    }

    this->opened = true;


    // Search for data tag, flag to check if inside of one
    bool inside_data = false;
    bool inside_name = false;
    bool opened_tag = false;

    std::string line{};
    std::string name{};
    std::vector<char> data_line{};
    std::vector<std::vector<char>> data{};
    // Iterate over all lines of xml
    while (std::getline(this->stream, line)) {
        // Flag to check if a tag is opened
        bool opened_tag = false;
        // Index to openning position
        int index_of_open;

        // Iterate over all chars on line
        for (int i = 0; i < line.length(); i++) {
            if (inside_data && (line[i] == '0' || line[i] == '1')) {
                // If inside tag, push the char
                data_line.push_back(line[i]);

            // Check if is a tag opening, can be reset in case
            // of a false opening
            } else if (line[i] == '<') {
                opened_tag = true;
                index_of_open = i;

            // Check if represent a closing tag
            } else if (line[i] == '>' && opened_tag) {
                opened_tag = false;

                // Get tag
                auto tag = line.substr(index_of_open, i+1 - index_of_open);
                // Avaliate tag
                if (tag.compare("<data>") == 0) {
                    inside_data = true;

                } else if (tag.compare("</data>") == 0) {
                    this->data_.push_back(data);
                    data.clear();
                    inside_data = false;

                } else if (tag.compare("<name>") == 0) {
                    inside_name = true;

                } else if (tag.compare("</name>") == 0) {
                    this->names_.push_back(name);
                    name.clear();
                    inside_name = false;
                }

            // Check if is inside a name tag
            } else if (inside_name && !opened_tag) {
                name.push_back(line[i]);
            }
        }
        // Pus line if is not empy
        if (!data_line.empty()) {
            data.push_back(data_line);
            data_line.clear();
        }
    }

    // Resete the stream
    this->stream.clear();
    this->stream.seekg(0);
}

XMLObject::~XMLObject() {
    this->stream.close();
}

std::vector<std::vector<std::vector<char>>> XMLObject::data() {
    return this->data_;
}

std::vector<std::string> XMLObject::names() {
    return this->names_;
}

bool XMLObject::is_opened() {
    return this->opened;
}

bool XMLObject::validate_xml() {
    // Check if stream was well opened
    if (!this->stream.good()) {
        // std::cout << "Stream not good!" << std::endl;
        return false;
    }

    auto stack = structures::LinkedStack<std::string>();
    std::string line;

    // Iterate over all lines of xml
    while (std::getline(this->stream, line)) {
        bool opened_tag = false;
        int index_of_open;

        // Iterate over all chars on line
        for (int i = 0; i < line.length(); i++) {
            if (line[i] == '<' && !opened_tag) {
                opened_tag = true;
                index_of_open = i;

            } else if (line[i] == '>' && opened_tag) {
                opened_tag = false;

                // Get tag
                auto tag = line.substr(index_of_open, i+1 - index_of_open);

                // Check if it is a closing tag
                if (tag[1] == '/') {
                    // Erase / from tag
                    tag.erase(1, 1);

                    // Check fi stack is empty, and a clsoing tag
                    // is before any openning, configuring invalid
                    // xml
                    if (stack.empty()) {
                        // std::cout << "Tag being closed before opened!\n";
                        return false;
                    }

                    // Check if current tag is equal to the top of stack
                    if (tag.compare(stack.top()) == 0) {
                        stack.pop();

                    // If tag without the '/' isn't equal to the top,
                    // one tag is being closed before is opened. So,
                    // configure a invalid xml
                    } else {
                        // std::cout << "Tag closed differ from last opened!\n";
                        return false;
                    }
                // If it is not a closing tag...
                } else {
                    // Push the tag on top of stack, because it is opening tag
                    stack.push(tag);
                }
            }
        }
    }
    // Resete the stream
    this->stream.clear();
    this->stream.seekg(0);

    // Return if stack is empty at the onde of process.
    // Stack not empty means that a tag wasn't closed,
    // configuring invalid xml anyway.
    return stack.empty();
}

void XMLObject::print_data() {
    for (auto mat : this->data_) {
        for (int j = 0; j < mat.size(); j ++) {
            for (int k = 0; k <  mat[j].size(); k++) {
                std::cout << mat[j][k];
            }
            std::cout << std::endl;
        }
        std::cout << std::endl << std::endl;
    }
}
