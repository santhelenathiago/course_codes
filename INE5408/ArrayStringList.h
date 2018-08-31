/// Copyright 2018 Thiago Sant' Helena

#pragma once

#include <cstdint>
#include <stdexcept>  // C++ Exceptions
#include <memory>
#include <cstring>



namespace structures {


//! Main class
template <typename T>
class ArrayList {
 public:
    //! Default constructor
    ArrayList();

    //! Parameter constructor
    explicit ArrayList(int max_size);

    //! Destructor
    ~ArrayList() = default;

    //! Reset the list
    void clear();

    //! Add element on the last position
    void push_back(const T& data);

    //! Add element on the first position
    void push_front(const T& data);

    //! Add element on any position
    void insert(const T& data, int index);

    //! Add element on a ordered list
    void insert_sorted(const T& data);

    //! Take element from a position
    T pop(int index);

    //! Take element from last position
    T pop_back();

    //! Take element from first position
    T pop_front();

    //! Remove any element
    void remove(const T& data);

    //! Check if list is full
    bool full() const;

    //! Check if list is empty
    bool empty() const;

    //! Check if a element is inside the list
    bool contains(const T& data) const;

    //! Find the position of the first occurence of an element
    int find(const T& data) const;

    //! Return size of the list
    int size() const;

    //! Return maximum size of a list
    int max_size() const;

    //! Take reference to an element
    T& at(int index);

    //! Operator for brackets
    T& operator[](int index);

    //! Polymorph for const object
    const T& at(int index) const;

    //! Polymorph for const object
    const T& operator[](int index) const;


 protected:
    //! Contents of list
    std::unique_ptr<T[]> contents;
    ///! actual size
    int size_;
    //! max size of list
    int max_size_;
    //! default max size, used on default constructor
    static const auto DEFAULT_MAX = 100u;
};

template <typename T>
structures::ArrayList<T>::ArrayList() {
    ArrayList(this->DEFAULT_MAX);
}

template <typename T>
structures::ArrayList<T>::ArrayList(int max_size) {
    this->size_ = 0;
    this->max_size_ = max_size;
    this->contents = std::unique_ptr<T[]>(new T[this->max_size_]);
}

template <typename T>
void structures::ArrayList<T>::clear() {
    this->size_ = 0;
}

template <typename T>
bool structures::ArrayList<T>::full() const {
    return this->size_ == this->max_size_;
}

template <typename T>
bool structures::ArrayList<T>::empty() const {
    return this->size_ == 0;
}

template <typename T>
bool structures::ArrayList<T>::contains(const T& data) const {
    return this->find(data) != this->size_;
}

template <typename T>
int structures::ArrayList<T>::size() const {
    return this->size_;
}

template <typename T>
int structures::ArrayList<T>::max_size() const {
    return this->max_size_;
}

template <typename T>
int structures::ArrayList<T>::find(const T& data) const {
    for (int i = 0; i < this->size_; i++) {
        if (data == this->contents[i]) {
            return i;
        }
    }

    return this->size_;
}

template <typename T>
void structures::ArrayList<T>::remove(const T& data) {
    int index = this->find(data);
    if (index < this->size_) {
        this->pop(index);
    }
}

template <typename T>
T& structures::ArrayList<T>::at(int index) {
    if (this->size_ < index || index < 0) {
        throw std::out_of_range("Index out of bounds.");
    } else {
        return this->operator[](index);
    }
}

template <typename T>
T& structures::ArrayList<T>::operator[](int index) {
    return this->contents[index];
}

template <typename T>
const T& structures::ArrayList<T>::at(int index) const {
    if (this->size_ < index || index < 0) {
        throw std::out_of_range("Index out of bounds.");
    } else {
        return this->operator[](index);
    }
}

template <typename T>
const T& structures::ArrayList<T>::operator[](int index) const {
    return this->contents[index];
}

template <typename T>
void structures::ArrayList<T>::push_front(const T& data) {
    if (this->full()) {
        throw std::out_of_range("List is full");
    } else {
        for (int i = this->size_; i > 0; i--) {
            this->contents[i] = this->contents[i-1];
        }
        this->size_ += 1;
        this->contents[0] = data;
    }
}

template <typename T>
void structures::ArrayList<T>::push_back(const T& data) {
    if (this->full()) {
        throw std::out_of_range("List is full");
    } else {
        this->contents[this->size_] = data;
        this->size_ += 1;
    }
}

template <typename T>
T structures::ArrayList<T>::pop_back() {
    if (this->empty()) {
        throw std::out_of_range("Empty list!");
    } else {
        this->size_ -= 1;
        return this->contents[this->size_];
    }
}

template <typename T>
T structures::ArrayList<T>::pop_front() {
    if (this->empty()) {
        throw std::out_of_range("Empty list!");
    } else {
        auto tmp = this->contents[0];

        for (int i = 0; i < this->size_ - 1; i++) {
            this->contents[i] = this->contents[i+1];
        }

        this->size_ -= 1;

        return tmp;
    }
}

template <typename T>
T structures::ArrayList<T>::pop(int index) {
    if (this->empty()) {
        throw std::out_of_range("List is empty");

    } else if (index >= this->size_ || index < 0) {
        throw std::out_of_range("Invalid index");
    }

    auto tmp = this->contents[index];

    for (int i = index; i < this->size_-1; i++) {
        this->contents[i] = this->contents[i+1];
    }

    this->size_ -= 1;
    return tmp;
}

template <typename T>
void structures::ArrayList<T>::insert(const T& data, int index) {
    if (this->full()) {
        throw std::out_of_range("Full list");

    } else if (index >= this->max_size_ || index < 0 || index > this->size_) {
        throw std::out_of_range("Index out of bounds");

    } else if (index == this->size_) {
        this->contents[this->size_] = data;
        this->size_ += 1;

    } else {
        for (int i = this->size_; i > index; i--) {
            this->contents[i] = this->contents[i-1];
        }

        this->contents[index] = data;
        this->size_ += 1;
    }
}

template <typename T>
void structures::ArrayList<T>::insert_sorted(const T& data) {
    if (this->full()) {
        throw std::out_of_range("Full list");

    } else {
        int i = 0;
        while (1) {
            if (i == this->size_) {
                this->contents[this->size_] = data;
                this->size_ += 1;
                break;
            }

            if (this->contents[i] > data) {
                this->insert(data, i);
                break;
            }

            i++;
        }
    }
}

//! ArrayListString e' uma especializacao da classe ArrayList
class ArrayListString : public ArrayList<char* > {
 public:
    //! Constructor for default size
    ArrayListString() : ArrayList() {}

    //! Constructor for specified size
    explicit ArrayListString(int max_size) : ArrayList(max_size) {}

    //! Destructor
    ~ArrayListString();

    //! Empty the list
    void clear();

    //! Push a value on end of list
    void push_back(const char* data);

    //! push a value on front of the list
    void push_front(const char* data);

    //! insert value on index
    void insert(const char* data, int index);

    //! insert value sorted
    void insert_sorted(const char* data);

    //! return indexed element and excludes from list
    char* pop(int index);

    //! return last element from lsit and excludes it
    char* pop_back();

    //! return first element of list and excludes
    char* pop_front();

    //! remove indexed element
    void remove(const char* data);

    //! check if contains an element.
    bool contains(const char* data);

    //! find index of first occurence
    int find(const char* data);
};

}  // namespace structures

structures::ArrayListString::~ArrayListString() {
    this->clear();
}

void structures::ArrayListString::clear() {
    for (int i = 0; i < this->size(); i++) {
        delete[] this->operator[](i);
    }

    ArrayList<char*>::clear();
}

void structures::ArrayListString::push_back(const char* data) {
    if (strlen(data) > 10000) {
        throw std::out_of_range("String too big");
    }
    char* input = new char[strlen(data) + 1];
    snprintf(input, strlen(data)+1, "%s", data);

    ArrayList<char*>::push_back(input);
}

void structures::ArrayListString::push_front(const char* data) {
    char* input = new char[strlen(data) + 1];
    snprintf(input, strlen(data)+1, "%s", data);

    ArrayList<char*>::push_front(input);
}

void structures::ArrayListString::insert(const char* data, int index) {
    if (strlen(data) > 10000) {
        throw std::out_of_range("String too big");
    }
    char* input = new char[strlen(data) + 1];
    snprintf(input, strlen(data)+1, "%s", data);

    ArrayList<char*>::insert(input, index);
}

void structures::ArrayListString::insert_sorted(const char* data) {
    if (strlen(data) > 10000) {
        throw std::out_of_range("String too big");
    } else if (this->full()) {
        throw std::out_of_range("Full list");

    } else {
        int i = 0;
        while (1) {
            if (i == this->size()) {
                this->insert(data, this->size());
                break;
            }

            if (strcmp(operator[](i), data) > 0) {
                this->insert(data, i);
                break;
            }

            i++;
        }
    }
}

int structures::ArrayListString::find(const char* data)  {
    for (int i = 0; i < this->size(); i++) {
        if (strcmp(data, this->operator[](i)) == 0) {
            return i;
        }
    }

    return this->size();
}

char* structures::ArrayListString::pop(int index) {
    if (this->empty()) {
        throw std::out_of_range("List is empty");

    } else if (index >= this->size_ || index < 0) {
        throw std::out_of_range("Invalid index");
    }

    auto tmp = this->contents[index];

    for (int i = index; i < this->size_-1; i++) {
        this->contents[i] = this->contents[i+1];
    }

    this->size_ -= 1;
    return tmp;
}

char* structures::ArrayListString::pop_back() {
    if (this->empty()) {
        throw std::out_of_range("Empty list!");
    } else {
        this->size_ -= 1;
        return this->contents[this->size_];
    }
}

char* structures::ArrayListString::pop_front() {
    if (this->empty()) {
        throw std::out_of_range("Empty list!");
    } else {
        auto tmp = this->contents[0];

        for (int i = 0; i < this->size_ - 1; i++) {
            this->contents[i] = this->contents[i+1];
        }

        this->size_ -= 1;

        return tmp;
    }
}

void structures::ArrayListString::remove(const char* data) {
    int index = this->find(data);
    if (index < this->size_) {
        delete[] this->pop(index);
    }
}

bool structures::ArrayListString::contains(const char* data) {
    return this->find(data) != this->size();
}
