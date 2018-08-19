/// Copyright 2018 Thiago Sant' Helena

#ifndef INE5408_ARRAYLIST_H_
#define INE5408_ARRAYLIST_H_

#include <cstdint>
#include <stdexcept>  // C++ Exceptions
#include <memory>


namespace structures {

//! Main class
template <typename T>
class ArrayList {
 public:
    //! Default constructor
    ArrayList();

    //! Parameter constructor
    explicit ArrayList(std::size_t max_size);

    //! Destructor
    ~ArrayList() = default;

    //! Reset the list
    void clear();

    //! Add element on the last position
    void push_back(const T& data);

    //! Add element on the first position
    void push_front(const T& data);

    //! Add element on any position
    void insert(const T& data, std::size_t index);

    //! Add element on a ordered list
    void insert_sorted(const T& data);

    //! Take element from a position
    T pop(std::size_t index);

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
    std::size_t find(const T& data) const;

    //! Return size of the list
    std::size_t size() const;

    //! Return maximum size of a list
    std::size_t max_size() const;

    //! Take reference to an element
    T& at(std::size_t index);

    //! Operator for brackets
    T& operator[](std::size_t index);

    //! Polymorph for const object
    const T& at(std::size_t index) const;

    //! Polymorph for const object
    const T& operator[](std::size_t index) const;

 private:
    std::unique_ptr<T[]> contents;
    std::size_t size_;
    std::size_t max_size_;

    static const auto DEFAULT_MAX = 10u;
};

}  // namespace structures

template <typename T>
structures::ArrayList<T>::ArrayList() {
    this->ArrayList(this->DEFAULT_MAX);
}

template <typename T>
structures::ArrayList<T>::ArrayList(std::size_t max_size) {
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
std::size_t structures::ArrayList<T>::size() const {
    return this->size_;
}

template <typename T>
std::size_t structures::ArrayList<T>::max_size() const {
    return this->max_size_;
}

template <typename T>
std::size_t structures::ArrayList<T>::find(const T& data) const {
    for (int i = 0; i < this->size_; i++) {
        if (data == this->contents[i]) {
            return i;
        }
    }

    return this->size_;
}

template <typename T>
void structures::ArrayList<T>::remove(const T& data) {
    std::size_t index = this->find(data);
    if (index < this->size_) {
        this->pop(index);
    }
}

template <typename T>
T& structures::ArrayList<T>::at(std::size_t index) {
    if (this->size_ < index || index < 0) {
        throw std::out_of_range("Index out of bounds.");
    } else {
        return this->operator[](index);
    }
}

template <typename T>
T& structures::ArrayList<T>::operator[](std::size_t index) {
    return this->contents[index];
}

template <typename T>
const T& structures::ArrayList<T>::at(std::size_t index) const {
    if (this->size_ < index || index < 0) {
        throw std::out_of_range("Index out of bounds.");
    } else {
        return this->operator[](index);
    }
}

template <typename T>
const T& structures::ArrayList<T>::operator[](std::size_t index) const {
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
T structures::ArrayList<T>::pop(std::size_t index) {
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
void structures::ArrayList<T>::insert(const T& data, std::size_t index) {
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

#endif  // INE5408_ARRAYLIST_H_
