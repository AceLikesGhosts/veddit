module veddit

// https://www.reddit.com/dev/api/
pub enum Kind {
	t1
	t2
	t3
	t4
	t5
	t6
}

pub fn valid_str(name string, str string) !bool {
	if !str.is_ascii() {
		return error('${name} was not ascii')
	}

	if str.is_blank() {
		return error('${name} was blank')
	}

	return true
}
