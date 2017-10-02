
describe 'Creates and outputs' do
  it 'a new image of 3 x 3 with all white pixels when I is command' do
    test_input = ['I 3 3', 'S']
    allow(File).to receive(:exists?).with('test_file').and_return(true)
    allow(File).to receive(:open).with('test_file').and_return(test_input)
    editor = BitmapEditor.new
    expected_output = "000\n000\n000\n"

    expect(STDOUT).to receive(:puts).with(expected_output)
    editor.run('test_file')
  end
  it 'a new image of 2 x 4 with all white pixels when I is command' do
    test_input = ['I 2 4', 'S']
    allow(File).to receive(:exists?).with('test_file').and_return(true)
    allow(File).to receive(:open).with('test_file').and_return(test_input)
    editor = BitmapEditor.new
    expected_output = "00\n00\n00\n00\n"

    expect(STDOUT).to receive(:puts).with(expected_output)
    editor.run('test_file')
  end
end
