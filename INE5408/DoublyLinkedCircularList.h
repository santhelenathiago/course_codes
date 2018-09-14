//! Copyright 2018 Thiago Sant' Helena

#pragma once

#include <stdexcept>

namespace structures {

//! Main class
template<typename T>
class DoublyCircularList {
 public:
    //! Default constructor
    DoublyCircularList() {
    }

    //! Destructor
    ~DoublyCircularList() {
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

        this->size_ = 0;
    }

    //! Push value in first position
    void push_back(const T& data) {
        if (this->empty()) {
            this->head = new Node(data);

        } else if (this->size_ == 1) {
            auto new_last = new Node(data,
                                     this->head,
                                     this->head);
            this->head->prev(new_last);
            this->head->next(new_last);

        } else {
            auto new_last = new Node(data,
                                     this->head,
                                     this->head->prev());
            this->head->prev()->next(new_last);
            this->head->prev(new_last);
        }

        this->size_++;
    }

    //! Push value on first position
    void push_front(const T& data) {
        if (this->empty()) {
            this->head = new Node(data);

        } else if (this->size_ == 1) {
            auto new_first = new Node(data,
                                      this->head,
                                      this->head);
            this->head->prev(new_first);
            this->head->next(new_first);
            this->head = new_first;

        } else {
            auto new_first = new Node(data,
                                      this->head,
                                      this->head->prev());
            this->head->prev()->next(new_first);
            this->head->prev(new_first);
            this->head = new_first;
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
            auto it = this->head->prev();

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
            if (it == this->head) {
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
        if (static_cast<float>(index) < this->size_/2.0) {
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
            auto it = this->head->prev();

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
        auto ptr = this->head->prev();
        auto ret = ptr->data();
        ptr->prev()->next(this->head);
        this->head->prev(ptr->prev());

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
        ptr->prev()->next(ptr->next());
        ptr->next()->prev(ptr->prev());
        this->head = ptr->next();

        this->size_--;

        delete ptr;
        return ret;
    }

    //! Remove element from list
    void remove(const T& data) {
        auto index = this->find(data);
        if (index != this->size_) {
            this->pop(index);
        }
    }

    //! Check for empty list
    bool empty() const {
        return this->size_ == 0;
    }

    //! Check if list contains element
    bool contains(const T& data) const {
        return this->find(data) != this->size_;
    }

    //! Return reference to target element
    T& at(int index) {
        if (index >= this->size_ || index < 0) {
            throw std::out_of_range("Index out of bounds");
        }
        if (static_cast<float>(index) < this->size_/2.0) {
            auto it = this->head;

            for (int i = 0; i < index; i++) {
                it = it->next();
            }

            return it->data();

        } else {
            auto it = this->head->prev();

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
        if (static_cast<float>(index) < this->size_/2.0) {
            auto it = this->head;

            for (int i = 0; i < index; i++) {
                it = it->next();
            }

            return it->data();

        } else {
            auto it = this->head->prev();

            for (int i = this->size_-1; i > index; i--) {
                it = it->prev();
            }

            return it->data();
        }
    }

    //! Find index of element
    int find(const T& data) const {
        if (data == this->head->data()) {
            return 0;
        }
        auto it = this->head->next();
        int index = 1;
        while (it->data() != data) {
            it = it->next();
            index++;

            if (it == this->head) {
                return this->size_;
            }
        }

        return index;
    }

    //! Return size of list
    int size() const {
        return this->size_;
    }

 private:
    class Node {
     public:
        explicit Node(const T& data) {
            this->data_ = data;
        }

        Node(const T& data, Node* next) {
            this->data_ = data;
            this->next_ = next;
        }

        Node(const T& data, Node* next, Node* prev) {
            this->data_ = data;
            this->next_ = next;
            this->prev_ = prev;
        }

        T& data() {
            return this->data_;
        }

        const T& data() const {
            return this->data_;
        }

        Node* prev() {
            return this->prev_;
        }

        const Node* prev() const {
            return this->prev_;
        }

        void prev(Node* node) {
            this->prev_ = node;
        }

        Node* next() {
            return this->next_;
        }

        const Node* next() const {
            return this->next_;
        }

        void next(Node* node) {
            this->next_ = node;
        }

     private:
        T data_;
        Node* prev_{nullptr};
        Node* next_{nullptr};
    };

    Node* head{nullptr};
    int size_{0};
};

}  // namespace structures
