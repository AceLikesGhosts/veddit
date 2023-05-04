module veddit

pub fn valid_str(name string, str string) ! {
	if !str.is_ascii() {
		return error('${name} was not ascii')
	}

	if str.is_blank() {
		return error('${name} was blank')
	}
}
