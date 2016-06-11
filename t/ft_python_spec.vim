runtime! plugin/doorboy.vim

source spec_helper.vim

set filetype=python

describe 'ftplugin/python'
  after
    normal ggdG
  end

  context 'when the cursor is behind r'
    before
      call spec_helper#put_with_cursor('r|')
    end
    context 'and putting "'
      it 'should put " twice'
        call spec_helper#append_chars('"regexp')
        Expect getline(1) == 'r"regexp"'
      end
    end
    context "and putting '"
      it "should put ' twice"
        call spec_helper#append_chars("'regexp")
        Expect getline(1) == "r'regexp'"
      end
    end
  end
end
