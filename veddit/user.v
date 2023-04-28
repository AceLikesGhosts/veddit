module veddit

import net.http { get }
import json

// user fetches a user from reddit, it pulls their /about.json and parses it into a V struct
pub fn user(name string) !User {
	mut resp := get('https://reddit.com/user/${name}/about.json') or {
		return error('Failed to get user
		(${name})\'s information (https://reddit.com/user/${name}/about.json).
		\nOriginal ${err}')
	}

	if resp.status_code == 404 {
		return error('Failed to find user (${name})\'s information (https://reddit.com/user/${name}/about.json)')
	}

	return json.decode(User, resp.body)
}

struct User {
pub:
	kind string
	data UserData
}

// a lot of data in this is limited to if you are logged in / if its your account (:
// glhf trying to tell which is which, cause i dont care!
struct UserData {
pub:
	accept_chats              bool
	accept_pms                bool
	accept_followers          bool
	awardee_karma             int
	awarder_karma             int
	can_create_subreddits     bool
	can_edit_name             bool
	coins                     int
	comment_karma             int
	created                   int
	created_utc               int
	features                  ?UserFeatures
	force_password_reset      bool
	gold_creddits             int // it is deadass spelled "creddits" in the data we get back.
	gold_expiration           int
	has_android_subscription  bool
	has_ios_subscription      bool
	has_mail                  bool
	has_mod_mail              bool
	has_paypal_subscription   bool
	has_stripe_subscription   bool
	has_subscribed            bool
	has_subscribed_to_premium bool
	has_verified_email        bool
	has_visited_new_profile   bool
	hide_from_robots          bool
	icon_img                  string
	id                        string
	in_beta                   bool
	in_redesign_beta          bool
	inbox_count               int
	is_blocked                bool
	is_employee               int
	is_friend                 bool
	is_gold                   bool
	is_mod                    bool
	is_sponsor                bool
	is_suspended              bool // LMFAO
	link_karma                int
	modhash                   string
	name                      string
	new_modmail_exists        bool // nullable
	num_friends               int
	over_18                   bool
	password_set              bool
	pref_autoplay             bool
	pref_clickgadget          int
	pref_geopopular           bool
	pref_nightmode            bool
	pref_no_profanity         bool
	pref_show_presence        bool
	pref_show_snoovatar       bool
	prev_show_trending        bool
	pref_show_twitter         bool
	pref_top_karma_subreddits bool
	pref_video_autoplay       bool
	snoovatar_img             string
	snoovatar_size            []int
	// subreddit -> im not typing this. fuck nested data
	suspension_expiration_utc int
	total_karma               int
	verified                  bool
}

struct UserFeatures {
pub:
	awards_on_streams                                         bool
	chat_group_rollout                                        bool
	chat_subreddit                                            bool
	chat_user_settings                                        bool
	cookie_consent_banner                                     bool
	crowd_control_for_post                                    bool
	do_not_track                                              bool
	expensive_coins_package                                   bool
	images_in_comments                                        bool
	is_email_permission_required                              bool
	mod_awards                                                bool
	mod_service_mute_reads                                    bool
	mod_service_mute_writes                                   bool
	modlog_copyright_removal                                  bool
	modmail_harassment_filter                                 bool
	mweb_xpromo_interstitial_comments_android                 bool
	mweb_xpromo_interstitial_comments_ios                     bool
	mweb_xpromo_modal_listing_click_daily_dismissible_android bool
	mweb_xpromo_modal_listing_click_daily_dismissible_ios     bool
	mweb_x_promo_revamp_v2                                    ?XpromoRevamp
	noreferrer_to_noopener                                    bool
	premium_subscriptions_table                               bool
	promoted_tend_blanks                                      bool
	resized_styles_image                                      bool
	show_amp_link                                             bool
	show_nps_survey                                           bool
	use_prefs_account_deployment                              bool
}

struct XpromoRevamp {
pub:
	experiment_id int
	owner         string
	variant       string
}
