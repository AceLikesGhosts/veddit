module veddit

fn test_valid_str() {
	assert valid_str('valid_str', 'awefawef')! == true
	expect_error_from_test_function('invalid_no_str', '', 'invalid_no_str was blank')
	expect_error_from_test_function('invalid_not_ascii', '日本語はクールな言語です、私はそれを学びたいです', 'invalid_not_ascii was not ascii')
}

fn expect_error_from_test_function(name string, str string, expected_error string) {
	valid_str(name, str) or {
		assert err.msg() == expected_error
		return
	}

	assert false
}
