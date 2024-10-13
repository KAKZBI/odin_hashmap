require_relative "linked_list.rb"

class HashMap 
    attr_accessor :capacity, :buckets, :collisions
    attr_reader :load_factor
    def initialize
        @capacity = 4
        @buckets = Array.new(self.capacity){LinkedList.new}
        @collisions = 0
        @load_factor = 0.75
    end
    def set(key, value)
        if self.length >= self.load_factor * self.capacity
            rehash
            self.set(key, value)
        else
            index = get_buckets_index(key)
            self.collisions += 1 if self.buckets[index].size >= 0
            #We update the value of the node if it is already in the bucket
            if self.buckets[index].contains?(key)
                rank = self.buckets[index].find_index(key)
                self.buckets[index].remove_at(rank)
                self.buckets[index].insert_at(key, value, rank)
            else
                self.buckets[index].append(key, value)
            end
        end
    end
    def get(key)
        index = get_buckets_index(key)
        return nil if !self.buckets[index].contains?(key)
        current_node = self.buckets[index].head_node
        while current_node do
            return current_node.value if current_node.key == key
            current_node = current_node.next_node
        end
    end
    def has(key)
        index = get_buckets_index(key)
        self.buckets[index].contains?(key)
    end
    def remove(key)
        return unless self.has(key)
        index = get_buckets_index(key)
        value = self.get(key)
        rank = self.buckets[index].find_index(key)
        self.buckets[index].remove_at(rank)
    end
    def length
        size = 0
        self.buckets.each do |bucket|
            size += bucket.size
        end
        size
    end
    def clear 
        self.buckets = Array.new(self.capacity){LinkedList.new}
        self.collisions = 0
    end
    def keys
        keys = []
        self.buckets.each do |bucket|
            # continue if bucket.size == 0
            current_node = bucket.head_node
            while current_node do
                keys << current_node.key
                current_node = current_node.next_node
            end
        end
        keys
    end
    def values
        values = []
        self.buckets.each do |bucket|
            # continue if bucket.size == 0
            current_node = bucket.head_node
            while current_node do
                values << current_node.value
                current_node = current_node.next_node
            end
        end
        values
    end
    def entries
        entries = []
        self.buckets.each do |bucket|
            # continue if bucket.size == 0
            current_node = bucket.head_node
            while current_node do
                entries << [current_node.key, current_node.value]
                current_node = current_node.next_node
            end
        end
        entries
    end

    private

    def hash(key)
        hash_code = 0
        prime_number = 31
           
        key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
           
        hash_code
    end
    def get_buckets_index(key)
        hash(key) % self.capacity
    end
    def rehash
        # We double the size of the buckets
        self.capacity *= 2
        self.collisions = 0 
        new_buckets = Array.new(self.capacity){LinkedList.new}
        # We transfer every key-value pair in the new buckets
        self.buckets.each do |bucket|

            current_node = bucket.head_node
            while current_node do
                new_index = get_buckets_index(current_node.key)
                new_buckets[new_index].append(current_node.key, current_node.value)
                self.collisions += 1 if new_buckets[new_index].size >= 1
                current_node = current_node.next_node
            end
        end
        self.buckets = new_buckets
    end
end

