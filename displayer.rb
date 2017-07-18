class Displayer
  def initialize(output = STDOUT)
    @output = output
  end

  def display(board)
    result = ''
    board.each_row do |row|
      row.each do |field|
        result << (field.live? ? '*' : ' ')
      end
      result << "\n"
    end
    result
  end
end
