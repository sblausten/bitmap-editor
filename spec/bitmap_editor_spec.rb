def draw_test_image(x, y, color)
  x = x.to_i
  y = y.to_i
  x == 0 || y == 0 ? "\n" : (color.to_s * x + "\n") * y
end

describe BitmapEditor do
  describe '#run' do
    before(:each) do
      allow(File).to receive(:exists?).with('test_file').and_return(true)
      @editor = BitmapEditor.new
    end
    describe 'I command followed by S' do
      context 'for individual values' do
        it 'outputs a new image of 3 x 3 with all white pixels' do
          test_input = ['I 3 3', 'S']
          allow(File).to receive(:open).with('test_file').and_return(test_input)
          expected_output = "000\n000\n000\n"
          expect{ @editor.run('test_file') }.to output(expected_output).to_stdout
        end
        it 'outputs a new image of 2 x 4 with all white pixels' do
          test_input = ['I 2 4', 'S']
          allow(File).to receive(:open).with('test_file').and_return(test_input)
          expected_output = "00\n00\n00\n00\n"
          expect{ @editor.run('test_file') }.to output(expected_output).to_stdout
        end
        it 'outputs a new image of 1 x 1 with all white pixels' do
          test_input = ['I 1 1', 'S']
          allow(File).to receive(:open).with('test_file').and_return(test_input)
          expected_output = "0\n"
          expect{ @editor.run('test_file') }.to output(expected_output).to_stdout
        end
      end
      context 'for edge cases' do
        it 'notifies user when no image created' do
          test_input = ['S']
          allow(File).to receive(:open).with('test_file').and_return(test_input)
          expected_output = "There is no image\n"
          expect{ @editor.run('test_file') }.to output(expected_output).to_stdout
        end
        it 'notifies user when file does not exist or is empty' do
          test_input = ['S']
          allow(File).to receive(:exists?).with('test_file').and_return(false)
          allow(File).to receive(:open).with('test_file').and_return(test_input)
          expected_output = "please provide correct file\n"
          expect{ @editor.run('test_file') }.to output(expected_output).to_stdout
        end
      end
      context 'for multiple random values' do
        it "always shows correct picture for square" do
          property_of {
            range(1, 10)
          }.check { |i|
            command = 'I ' + i.to_s + ' ' + i.to_s
            test_input = [command, 'S']
            allow(File).to receive(:open).with('test_file').and_return(test_input)
            expected_output = draw_test_image(i, i, 0)
            output = capture_stdout { @editor.run('test_file') }
            expect(output).to eq(expected_output)
          }
        end
        it "always shows correct picture for separate x and y values" do
          property_of {
            array(2) { range(1, 10) }
          }.check { |array|
            x = array[0].to_s
            y = array[1].to_s
            command = 'I ' + x + ' ' + y
            test_input = [command, 'S']
            allow(File).to receive(:open).with('test_file').and_return(test_input)
            expected_output = draw_test_image(x, y, 0)
            output = capture_stdout { @editor.run('test_file') }
            expect(output).to eq(expected_output)
           }
        end
        it "always shows correct char number for separate x and y values" do
          property_of {
            array(2) { range(1, 10) }
          }.check { |array|
            x = array[0]
            y = array[1]
            command = 'I ' + x.to_s + ' ' + y.to_s
            test_input = [command, 'S']
            allow(File).to receive(:open).with('test_file').and_return(test_input)
            output = capture_stdout { @editor.run('test_file') }
            expect(output.length).to eq(x * y + y)
           }
        end
        it "always shows correct char number for large x and y values" do
          property_of {
            array(2) { range(1000, 10000) }
          }.check(10) { |array|
            x = array[0]
            y = array[1]
            command = 'I ' + x.to_s + ' ' + y.to_s
            test_input = [command, 'S']
            allow(File).to receive(:open).with('test_file').and_return(test_input)
            output = capture_stdout { @editor.run('test_file') }
            expect(output.length).to eq(x * y + y)
           }
        end
      end
    end
  end
end
