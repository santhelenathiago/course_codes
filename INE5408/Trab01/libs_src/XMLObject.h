// Copyright 2018 Thiago Sant' Helena

#pragma once

#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include "LinkedStack.h"

//! xml Object
/*! Class to describe XML object, including data in 
    * tags and validation of xml files 
    */
class XMLObject {
 private:
    std::vector<std::vector<std::vector<char>>> data_;
    std::vector<std::string> names_;
    bool opened;
    std::ifstream stream;

    //! xml validator
    /*! XML validator function, receive input, do shenanigans and return
     *  true or false. If file doesn't exists, print fail and return false 
     * 
     *  A invalid XML is caracterized by:
     *   - Closing a tag before it was opened
     *   - A tag not being closed at the end of file
     *   - A tag being closed but it was not the last to being opened
     *  
     * \param input_xml input std::string filename to be validate
     * \return true if it is a valid XML, otherwise, false.
     */
    bool validate_xml();


 public:
    //! Move constructor
    // XMLObject(XMLObject&&) = default;

    //! Constructor with input file
    /*! Constructor with input file, initiate every attributte accordingly
     *  to input file, also checks if the file is a valid xml.
     */
    explicit XMLObject(const std::string& input_file);

    //! Destructor
    /*! Destructor will close input stream
     */
    ~XMLObject();

    //! Check if object was correctly opened
    /*! \return true if file was validated and attributtes organized,
        false otherwise
     */
    bool is_opened();

    //! Get content of data tags, organized in vectors
    /*! \return content of data tags organized by tag, ordered by lecture then,
     *  by line read in file, each caracter in one position of vector.
     */
    std::vector<std::vector<std::vector<char>>> data();

    //! Get content of name tags, organized in a vector
    /*! \return content of data tags organized by tag, ordered by lecture then,
     *  by line read in file, each caracter in one position of vector.
     */
    std::vector<std::string> names();


    //! Print data in std::cout
    /*! For debugging process, prints the data stored, formatted
     */
    void print_data();
};
