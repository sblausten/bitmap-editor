require './lib/bitmap_editor'

describe 'creates and outputs' do
  it 'a new image of 3 x 3 with all white pixels' do
    test_input = ['I 3 3', 'S']
    allow(File).to receive(:exists?).with('test_file').and_return(true)
    allow(File).to receive(:open).with('test_file').and_return(test_input)
    editor = BitmapEditor.new
    expected_output = "000\n000\n000\n"

    expect(STDOUT).to receive(:puts).with(expected_output)
    editor.run('test_file')
  end
end
describe 'when no image created' do
  it 'notifies user' do
    test_input = ['S']
    allow(File).to receive(:exists?).with('test_file').and_return(true)
    allow(File).to receive(:open).with('test_file').and_return(test_input)
    editor = BitmapEditor.new
    expected_output = "There is no image"

    expect(STDOUT).to receive(:puts).with(expected_output)
    editor.run('test_file')
  end
end
describe 'when file does not exist or is empty' do
  it 'notifies user' do
    test_input = ['S']
    allow(File).to receive(:exists?).with('test_file').and_return(false)
    allow(File).to receive(:open).with('test_file').and_return(test_input)
    editor = BitmapEditor.new
    expected_output = "please provide correct file"

    expect(STDOUT).to receive(:puts).with(expected_output)
    editor.run('test_file')
  end
end
