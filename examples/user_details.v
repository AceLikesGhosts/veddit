module main

import veddit

fn main() {
	user := veddit.about_user('acelikesaudio') or {
		println('${err}')
		return
	}

	println('account was created at ${user.data.created_utc} UTC')
}
