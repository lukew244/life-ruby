class Board

  def initialize(x,y)
    @fields = Array.new(y) { Array.new(x) { Field.new } }
  end

  def each_row(&block)
    @fields.each(&block)
  end

  def display(displayer = Displayer.new)
    displayer.display(self)
  end

  def step
    @fields.each.with_index do |row, y|
      row.each.with_index do |field, x|
        if field.live?
          field.dead! if [2,3].include? get_neighbours(x,y)
        else
          field.live! if get_neighbours(x,y) == 3
        end
      end
    end
  end

  private

  def get_neighbours(x,y)
    (-1..1).to_a.product((-1..1).to_a).count do |dx, dy|
      next false if [dx, dy].all? &:zero?
      get_field(x + dx, y + dy)&.live?
    end
  end

  def get_field(x,y)
    return if [x,y].any? &:negative?
    return unless row = @fields[y]
    row[x]
  end

  class Field
    def initialize
      @alive = [true, false].sample
    end

    def live?
      !!@alive
    end

    def live!
      @alive = true
    end

    def dead!
      @alive = false
    end
  end

end
