runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'doorboy#quotations'
  before
    new
  end

  after
    close!
  end

  context 'when no characters in the current line'
    " double quotation "
    context 'and putting "#'
      it 'should be "#"'
        call spec_helper#insert_chars('"#')
        Expect getline(1) == '"#"'
      end
    end

    context 'and putting ""#'
      it 'should be ""#'
        call spec_helper#insert_chars('""#')
        Expect getline(1) == '""#'
      end
    end

    " single quotation '
    context "and putting '#"
      it "should be '#'"
        call spec_helper#insert_chars("'#")
        Expect getline(1) == "'#'"
      end
    end

    context "and putting ''#"
      it "should be ''#"
        call spec_helper#insert_chars("''#")
        Expect getline(1) == "''#"
      end
    end

    " back quotation `
    context "and putting `#"
      it "should be `#`"
        call spec_helper#insert_chars("`#")
        Expect getline(1) == "`#`"
      end
    end

    context "and putting ``#"
      it "should be ``#"
        call spec_helper#insert_chars("``#")
        Expect getline(1) == "``#"
      end
    end
  end

  context 'when cursor is between quotations'
    before
      call spec_helper#put_with_cursor('"|"')
    end

    context 'and pressing backspace'
      it 'should delete both quotations'
        call spec_helper#insert_bs()
        Expect getline(1) == ''
      end
    end

    context 'and pressing the same quotation as written'
      it 'should skip the quotation'
        call spec_helper#insert_chars('"#')
        Expect getline(1) == '""#'
      end
    end
  end

  context 'when cursor is left of word'
    before
      call spec_helper#put_with_cursor('|word')
    end

    context 'and pressing "'
      it 'should be "word'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"word'
      end
    end
  end

  context 'when cursor is left of NOT word'
    before
      call spec_helper#put_with_cursor('|,word')
    end

    context 'and pressing "'
      it 'should be "word'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"",word'
      end
    end
  end

  context 'when cursor is right of word'
    before
      call spec_helper#put_with_cursor('word|')
    end

    context 'and pressing "'
      it 'should be word"'
        call spec_helper#append_chars('"')
        Expect getline(1) == 'word"'
      end
    end
  end
end
