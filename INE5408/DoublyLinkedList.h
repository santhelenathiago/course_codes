// Copyright 2018 Thiago Sant' Helena

#pragma once

#include <stdexcept>  // C++ Exceptions
#include <memory>     // smart pointers

namespace structures {

template<typename T>
//! Main class
class DoublyLinkedList {
 public:
    //! Default constructor
    DoublyLinkedList() {}

    //! Destructor
    ~DoublyLinkedList() {
        this->clear();
    }

    //! clear list
    void clear() {
        auto it = this->head;
        Node* other;
        for (int i = 0; i < this->size_; i++) {
            other = it->next();
            delete it;
            it = other;
        }

        this->head = nullptr;
        this->tail = nullptr;

        this->size_ = 0;
    }

    //! Push element on last position
    void push_back(const T& data) {
        if (this->empty()) {
            this->head = new Node(data);
            this->tail = this->head;

        } else {
            auto tmp = this->tail;
            this->tail = new Node(data);

            this->tail->prev(tmp);

            tmp->next(this->tail);
        }
        this->size_++;
    }

    //! Push element on first position
    void push_front(const T& data) {
        if (this->empty()) {
            this->head = new Node(data);
            this->tail = this->head;
        } else {
            auto tmp = this->head;
            this->head = new Node(data);

            this->head->next(tmp);

            tmp->prev(this->head);
        }
        this->size_++;
    }

    //! Insert element on target index
    void insert(const T& data, int index) {
        if (index > this->size_ || index < 0) {
            throw std::out_of_range("Index out of bounds");
        }
        if (index == 0) {
            this->push_front(data);
            return;

        } else if (index == this->size_) {
            this->push_back(data);
            return;

        } else if (index < this->size_/2) {
            auto it = this->head;

            for (int i = 0; i < index; i++) {
                it = it->next();
            }

            // Create unique_ptr to new node
            auto new_node = new Node(data);
            new_node->next(it);
            new_node->prev(it->prev());
            it->prev()->next(new_node);
            it->prev(new_node);

        } else {
            auto it = this->tail;

            for (int i = this->size_-1; i > index; i--) {
                it = it->prev();
            }

            // Create unique_ptr to new node
            auto new_node = new Node(data);
            new_node->next(it);
            new_node->prev(it->prev());
            it->prev()->next(new_node);
            it->prev(new_node);
        }

        this->size_++;
    }

    //! Insert element sorted
    void insert_sorted(const T& data) {
        // If list is empty, just push
        if (this->empty()) {
            this->push_back(data);
            return;
        }

        auto it = this->head;
        int index = 0;

        while (it->data() < data) {
            it = it->next();
            index++;

            // If reach the last object, push on last pos
            if (it == nullptr) {
                this->push_back(data);
                return;
            }
        }

        this->insert(data, index);
    }


    //! Pop target element
    T pop(int index) {
        if (index >= this->size_ || index < 0) {
            throw std::out_of_range("Index out of bounds");
        }
        if (index == 0) {
            return this->pop_front();
        }
        if (index == this->size_-1) {
            return this->pop_back();
        }
        if (index < this->size_/2) {
            auto it = this->head;

            for (int i = 0; i < index; i++) {
                it = it->next();
            }

            // Set prev's node of "if" next as next of it,
            // passing the ownership of next of it
            it->prev()->next(it->next());
            it->next()->prev(it->prev());

            this->size_--;
            auto ret = it->data();
            delete it;
            return ret;
        } else {
            auto it = this->tail;

            for (int i = this->size_-1; i > index; i--) {
                it = it->prev();
            }

            // Set prev's node of "if" next as next of it,
            // passing the ownership of next of it
            it->prev()->next(it->next());
            it->next()->prev(it->prev());

            this->size_--;
            auto ret = it->data();
            delete it;
            return ret;
        }
    }

    //! Pop last element
    T pop_back() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }
        auto ptr = this->tail;
        auto ret = this->tail->data();
        this->tail = this->tail->prev();

        this->size_--;

        delete ptr;
        return ret;
    }

    //! Pop first element
    T pop_front() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }

        auto ptr = this->head;
        auto ret = this->head->data();
        this->head = ptr->next();

        this->size_--;

        delete ptr;
        return ret;
    }

    //! Remove target element
    void remove(const T& data) {
        auto index = this->find(data);
        if (index != this->size()) {
            this->pop(index);
        }
    }

    //! Check for empty list
    bool empty() const {
        return this->size_ == 0;
    }

    //! Check if list contains element
    bool contains(const T& data) const {
        return this->find(data) != this->size();
    }

    //! Return reference to target element
    T& at(int index) {
        if (index >= this->size_ || index < 0) {
            throw std::out_of_range("Index out of bounds");
        }
        if (index < this->size_/2) {
            auto it = this->head;

            for (int i = 0; i < index; i++) {
                it = it->next();
            }

            return it->data();

        } else {
            auto it = this->tail;

            for (int i = this->size_-1; i > index; i--) {
                it = it->prev();
            }

            return it->data();
        }
    }

    //! Return const reference to target element
    const T& at(int index) const {
        if (index >= this->size_ || index < 0) {
            throw std::out_of_range("Index out of bounds");
        }
        if (index < this->size_/2) {
            auto it = this->head;

            for (int i = 0; i < index; i++) {
                it = it->next();
            }

            return it->data();

        } else {
            auto it = this->tail;

            for (int i = this->size_-1; i > index; i--) {
                it = it->prev();
            }

            return it->data();
        }
    }

    //! Find index of element
    int find(const T& data) const {
        auto it = this->head;
        int i = 0;
        while (it != nullptr) {
            if (it->data() == data) {
                return i;
            }

            i++;
            it = it->next();
        }

        return i;
    }

    //! Return size of list
    int size() const {
        return this->size_;
    }

 private:
    class Node {  // Elemento
     public:
        explicit Node(const T& data):
            data_{data}
        {}

        T& data() {
            return data_;
        }

        const T& data() const {
            return data_;
        }

        Node* next() {
            return next_;
        }

        Node* prev() {
            return prev_;
        }

        const Node* next() const {
            return next_;
        }

        const Node* prev() const {
            return prev_;
        }

        void next(Node* node) {
            next_ = node;
        }

        void prev(Node* node) {
            prev_ = node;
        }

     private:
        T data_;
        Node* next_{nullptr};
        Node* prev_{nullptr};
    };

    Node* head{nullptr};  // primeiro da lista
    Node* tail{nullptr};  // ultimo da lista
    int size_{0};
};

}  // namespace structures
