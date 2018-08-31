/// Copyright 2018 Thiago Sant' Helena

#ifndef INE5408_ARRAYNODELIST_H_
#define INE5408_ARRAYNODELIST_H_

#include <cstdint>
#include <stdexcept>  // C++ Exceptions
#include <memory>


namespace structures {

//! Node class
template <typename T>
class Node {
 public:
    //! Default constructor, must have initial values
    Node(const T& data, int next_index) {
        this->data = data;
        this->next_index_ = next_index;
    }

    Node() = default;

    //! next_index setter
    void set_next_index(int next_index) {
        this->next_index_ = next_index;
    }

    //! Data setter
    void set_value(const T& data) {
        this->data = data;
    }

    //! next_index getter
    int next_index() {
        return this->next_index_;
    }

    //! Value getter
    T& value() {
        return this->data;
    }

 private:
    int next_index_;
    T data;
};

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
    std::unique_ptr<Node<T>[]> contents;
    std::size_t size_;
    std::size_t max_size_;
    int first_empty_, first_full_;

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
    this->contents = std::unique_ptr<Node<T>[]>(new Node<T>[this->max_size_]);

    for (int i  = 0; i < this->max_size_; i++) {
        this->contents[i] = Node<T>(T(), i+1);
    }

    this->contents[this->max_size_-1].set_next_index(-1);
    this->first_empty_ = 0;
    this->first_full_ = -1;
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
    int index = this->first_full_;
    while (1) {
        if (index == -1) {
            return this->size_;
        } else if (data == this->contents[index].value()) {
            return index;
        } else {
            index = this->contents[index].next_index();
        }
    }
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
    int target = this->first_full_;
    for (int i = 0; i < index; i++) {
        target = this->contents[target].next_index();
    }
    return this->contents[target].value();
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
    int target = this->first_full_;
    for (int i = 0; i < index; i++) {
        target = this->contents[target].next_index();
    }
    return this->contents[target].value();
}

template <typename T>
void structures::ArrayList<T>::push_front(const T& data) {
    if (this->full()) {
        throw std::out_of_range("List is full");

    } else {
        int second_full = this->first_full_;
        this->first_full_ = this->first_empty_;
        this->first_empty_ = this->contents[first_empty_].next_index();

        this->contents[first_full_] = Node<T>(data, second_full);
    }
}

template <typename T>
void structures::ArrayList<T>::push_back(const T& data) {
    if (this->full()) {
        throw std::out_of_range("List is full");

    } else {
        int index_to_push = this->first_empty_;

        // Set new first_empty_
        this->first_empty_ = this->contents[this->first_empty_].next_index();

        int index = this->first_full_;
        // Set the next_index of the second_last
        while (1) {
            if (this->contents[index].next_index() == -1) {
                this->contents[index].set_next_index(index_to_push);
                break;

            } else {
                index = this->contents[index].next_index();
            }
        }

        // Create new back
        this->contents[index_to_push] = Node<T>(data, -1);
        // Set new first_full_
        this->first_full_ = index_to_push;
        this->size_ += 1;
    }
}

template <typename T>
T structures::ArrayList<T>::pop_back() {
    if (this->empty()) {
        throw std::out_of_range("Empty list!");

    } else {
        // Auxiliar variables
        Node<T>* previous = NULL;
        int index = this->first_full_;

        // Find last object
        while (1) {
            if (this->contents[index].next_index() == -1) {
                // Set new first_empty with the position of the new last
                this->first_empty_ = index;

                // If has no previous, set first_full_ to -1
                // Else, set the previous' next_index to -1
                if (previous == NULL) {
                    this->first_full_ = -1;

                } else {
                    previous->set_next_index(-1);
                }

                this->size_ -= 1;
                return this->contents[index].value();

            } else {
                previous = &this->contents[index];
                index = this->contents[index].next_index();
            }
        }
    }
}

template <typename T>
T structures::ArrayList<T>::pop_front() {
    if (this->empty()) {
        throw std::out_of_range("Empty list!");

    } else {
        // Set new first_empty
        this->first_empty_ = this->first_full_;
        // Store first_full_ value
        T tmp = this->contents[this->first_full_].value();
        // Set new first_full_
        this->first_full_ = this->contents[this->first_full_].next_index();

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

    } else {
        // Find popped
        int popped = this->first_full_;
        Node<T>* previous;

        for (int i = 0; i < index; i++) {
            previous = &this->contents[popped];
            popped = this->contents[popped].next_index();
        }

        T tmp = this->contents[popped].value();

        if (previous == NULL) {
            this->first_full_ = this->contents[popped].next_index();

        } else {
            previous->set_next_index(this->contents[popped].next_index());
        }

        this->size_ -= 1;
        return tmp;
    }
}

template <typename T>
void structures::ArrayList<T>::insert(const T& data, std::size_t index) {
    if (this->full()) {
        throw std::out_of_range("Full list");

    } else if (index >= this->max_size_ || index < 0 || index > this->size_) {
        throw std::out_of_range("Index out of bounds");

    } else if (index == this->size_) {
        this->push_back(data);

    } else if (index == 0) {
        this->push_front(data);

    } else {
        // Find index
        int index_to_insert = this->first_full_;
        Node<T>* previous;

        for (int i = 0; i < index; i++) {
            previous = &this->contents[index_to_insert];
            index_to_insert = this->contents[index_to_insert].next_index();
        }
        // Set previous next_index to the first_empty
        previous->set_next_index(this->first_empty_);
        // Set new node
        this->contents[this->first_empty_] = Node<T>(data, index_to_insert);
        // Update first_empty
        this->first_empty_ = this->contents[this->first_empty_].next_index();
    }
}

template <typename T>
void structures::ArrayList<T>::insert_sorted(const T& data) {
    if (this->full()) {
        throw std::out_of_range("Full list");

    } else {
        int index = this->first_full_;
        int i = 0;
        while (1) {
            if (index == -1) {
                this->push_back(data);
                break;

            } else if (this->contents[i].value() < data) {
                this->insert(data, i);
                break;

            } else {
                index = this->contents[index].next_index();
                i++;
            }
        }
    }
}

#endif  // INE5408_ARRAYNODELIST_H_
