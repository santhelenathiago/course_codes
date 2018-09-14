//! Copyright 2018 Thiago Sant' Helena

#pragma once

#include <stdexcept>

namespace structures {

//! Main class
template<typename T>
class CircularList {
 public:
    //! Default constructor
    CircularList() {
        this->pivot = new Node();
    }

    //! Destructor
    ~CircularList() {
        this->clear();
        delete this->pivot;
    }

    //! Empty the list
    void clear() {
        auto it = this->pivot->next();
        Node* other;
        for (int i = 0; i < this->size_; i++) {
            other = it->next();
            delete it;
            it = other;
        }

        this->pivot->next(nullptr);
        this->pivot->prev(nullptr);

        this->size_ = 0;
    }

    //! Push value in first position
    void push_back(const T& data) {
        if (this->empty()) {
            this->pivot->next(new Node(data));
            this->pivot->prev(this->pivot->next());

        } else {
            auto old_last = this->pivot->prev();
            this->pivot->prev(new Node(data));
            this->pivot->prev()->next(this->pivot);
            old_last->next(this->pivot->prev());
        }

        this->size_ += 1;
    }


    //! Push value on first position
    void push_front(const T& data) {
        if (this->empty()) {
            this->pivot->next(new Node(data));
            this->pivot->prev(this->pivot->next());

        } else {
            this->pivot->next(new Node(data,
                                       this->pivot->next(),  // next
                                       nullptr));  // prev
        }

        this->size_ += 1;
    }

    //! Insert element on target position
    void insert(const T& data, int index) {
        if (index < 0 || index > this->size()) {
            throw std::out_of_range("Index out of bounds.");
        }

        if (index == 0) {
            this->push_front(data);
            return;

        } else if (index == this->size()) {
            this->push_back(data);
            return;
        }

        auto it = this->pivot->next();
        for (int i = 0; i < index-1; i++) {
            it = it->next();
        }
        it->next(new Node(data,
                          it->next(),
                          nullptr));

        this->size_++;
    }

    //! Insert ordered element
    void insert_sorted(const T& data) {
        // If list is empty, just push
        if (this->empty()) {
            this->push_back(data);
            return;
        }

        auto it = this->pivot->next();
        int index = 0;

        while (it->data() < data) {
            it = it->next();
            index++;

            // If reach the last object, push on last pos
            if (it == this->pivot || it == nullptr) {
                this->push_back(data);
                return;
            }
        }

        this->insert(data, index);
    }

    //! Return ref to element on target index
    T& at(int index) {
        if (index < 0 || index >= this->size()) {
            throw std::out_of_range("Index out of bounds.");
        }

        auto it = this->pivot->next();
        for (int i = 0; i < index; i++) {
            it = it->next();
        }

        return it->data();
    }

    //! Return const ref to element on target index
    const T& at(int index) const {
        if (index < 0 || index >= this->size()) {
            throw std::out_of_range("Index out of bounds.");
        }

        auto it = this->pivot->next();
        for (int i = 0; i < index; i++) {
            it = it->next();
        }

        return it->data();
    }

    //! Pop target element
    T pop(int index) {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }
        if (index >= this->size() || index < 0) {
            throw std::out_of_range("Index out of bounds.");
        }
        if (index == 0) {
            return this->pop_front();
        }
        if (index == this->size() - 1) {
            return this->pop_back();
        }

        auto before = this->pivot->next();
        for (int i = 0; i < index-1; i++) {
            before = before->next();
        }

        auto indexed = this->pivot->next();
        for (int i = 0; i < index; i++) {
            indexed = indexed->next();
        }

        auto tmp = indexed->data();
        before->next(indexed->next());

        this->size_--;

        delete indexed;

        return tmp;
    }

    //! Pop last element
    T pop_back() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }

        auto ptr = this->pivot->prev();
        auto tmp = this->pivot->prev()->data();
        this->size_--;
        this->pivot->prev(this->end());
        delete ptr;
        return tmp;
    }

    //! Pop first element
    T pop_front() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }

        auto ptr = this->pivot->next();
        auto tmp = this->pivot->next()->data();
        this->pivot->next((this->pivot->next()->next()));
        this->size_--;
        delete ptr;
        return tmp;
    }

    //! Remove target element
    void remove(const T& data) {
        auto index = this->find(data);
        auto it = this->pivot->next();
        for (int i = 0; i < index-1; i++) {
            it = it->next();
        }

        auto tmp = it->next();
        it->next(tmp->next());

        delete  tmp;
        this->size_--;
    }

    //! Check for empty list
    bool empty() const {
        return this->size_ == 0;
    }

    //! Check if list contains element
    bool contains(const T& data) const {
        return this->find(data) != this->size_;
    }

    //! Find index of element by value
    int find(const T& data) const {
        auto it = this->pivot->next();
        int i = 0;
        while (it != this->pivot) {
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
        Node() = default;

        explicit Node(const T& data):
            data_{data}
        {}

        Node(const T& data, Node* next, Node* prev):
            data_{data}, next_{next}, prev_{prev}
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

    Node* end() {
        auto it = this->pivot->next();
        for (int i = 1; i < size(); ++i) {
            it = it->next();
        }
        return it;
    }

    Node* pivot{nullptr};
    int size_{0};
};

}  // namespace structures
