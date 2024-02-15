class Node
    attr_accessor :key, :value, :next_node
    def initialize(key = nil, value = nil, next_node = nil)
        @key = key
        @value = value
        @next_node = next_node
    end
end
class LinkedList
    attr_accessor :head_node
    def initialize(head_node = nil)
        @head_node = head_node
    end
    def append(key, value)     
        new_node = Node.new(key, value)
        if !@head_node
            @head_node = new_node 
            return
        end
        current_node = @head_node
        while current_node.next_node do
            current_node = current_node.next_node
        end
        current_node.next_node = new_node
    end
    
    def prepend(key, value)
        new_node = Node.new(key, value, @head_node)
        @head_node = new_node
    end

    def size
        return 0 unless @head_node
        current_node = @head_node
        current_index = 0
        while current_node.next_node do
            current_node = current_node.next_node
            current_index += 1
        end
        return current_index + 1
    end

    def head
        return @head_node
    end

    def tail
        return nil unless @head_node
        current_node = @head_node
        previous_node = nil
        while current_node do
            previous_node = current_node
            current_node = current_node.next_node
        end
        return previous_node
    end

    def at(index)
        return nil unless index < self.size
        current_node = self.head_node
        current_index = 0
        while current_index < index -1 
            current_node = current_node.next_node
            current_index += 1
        end
        return current_node
    end
    def pop()
        current_node = @head_node 
        if self.size == 1
            last_node = @head_node
            @head_node = @head_node.next_node #Make it nil
            return last_node
        end
        second_to_last_node = nil
        while current_node.next_node do
            second_to_last_node = current_node
            current_node = current_node.next_node
        end
        second_to_last_node.next_node = current_node.next_node #Make it nil
        current_node
    end
    
    def contains?(key)
        current_node = self.head_node
        while current_node do
            return true if current_node.key == key
            current_node = current_node.next_node
        end
        return false
    end

    def find_index(key)
        current_node = self.head_node
        current_index = 0
        while current_node
            return current_index if current_node.key == key
            current_node = current_node.next_node
            current_index += 1
        end
        return nil
    end
    def to_s
        current_node = self.head_node
        string = ""
        while current_node
            string << "( #{current_node.value} ) -> "
            current_node = current_node.next_node
        end
        string << "nil"
        return string
    end

    def insert_at(key, value, index)
        if index == 0
            # Simply set the first node to be what is currently the second node:
            self.prepend(key, value)
            return
        end
        current_node = self.head_node
        current_index = 0
        new_node = Node.new(key, value)
        while current_index < (index - 1)
            current_node = current_node.next_node
            current_index += 1
        end
        new_node.next_node = current_node.next_node
        current_node.next_node = new_node
    end

    def remove_at(index)
        return if index >= self.size
        # If we are deleting the first node:
        if index == 0
            # Simply set the first node to be what is currently the second node:
            self.head_node = head_node.next_node
            return
        end
        current_node = self.head_node
        current_index = 0
        while current_index < index - 1
            current_node = current_node.next_node
            current_index += 1
        end
        # We find the node that comes after the one we're deleting:
        node_after_deleted_node = current_node.next_node.next_node
        # We change the link of the current_node to point to the
        # node_after_deleted_node, leaving the node we want
        # to delete out of the list:
        current_node.next_node = node_after_deleted_node
    end
end

# node_1 = Node.new(1, "once")
# node_2 = Node.new(2, "upon")
# node_3 = Node.new(3, "a")
# node_4 = Node.new(4, "time")
# node_1.next_node = node_2
# node_2.next_node = node_3
# node_3.next_node = node_4

# list = LinkedList.new(node_1)

# puts list

# list.insert_at(5, "I think", 2)

# puts list

# list.remove_at(4)
# puts list