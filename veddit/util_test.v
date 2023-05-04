module veddit

fn test_valid_str() {
	assert valid_str('valid', 'awfasfaf')! == true
	assert valid_str('invalid_no_str', '') or { false } == false
	assert valid_str('invalid_not_ascii', '日本語はクールな言語です、私はそれを学びたいです') or {
		false
	} == false
}
