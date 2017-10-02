class BitmapEditor

  def initialize
    @image = 'There is no image'
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      param = line.split(' ')
      command = param[0]
      x = param[1]
      y = param[2]
      case command
      when 'I'
        @image = draw_image(x, y)
      when 'S'
        puts @image
      else
        puts 'unrecognised command :('
      end
    end
  end

  private

  def draw_image(x, y, color = 0)
    x = x.to_i
    y = y.to_i
    line = draw_line(x, color) + "\n"
    line * y
  end

  def draw_line(x, color)
    code = color.to_s
    code * x
  end
end
