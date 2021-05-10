class PolyTreeNode
  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent
    @parent
  end


  def parent=(parent_node)
    return parent_node if self.parent == parent_node # edge case
    old_parent = self.parent # old parent is currently nil
    @parent = parent_node  # set n1 to be n1's parent
    parent_node.children << self if !parent_node.nil? #if parent_node is not nil, add n3 to its children
    old_parent.children.delete(self) if !old_parent.nil?
    parent_node
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node) #says n3 is the child of n1, get rid of it
    if !self.children.include?(child_node) #check if n3 is in n1.children
      raise "This node is not a child, cannot remove."
    end
      child_node.parent = nil
  end

  def dfs(target_value = nil)
    return nil if self.nil?
    return self if self.value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      first_element = queue.shift
      if first_element.value == target_value
        return first_element
      else
        queue.concat(first_element.children)
      end
    end
    nil
  end



end