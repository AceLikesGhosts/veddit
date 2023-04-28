module veddit

import net.http { get }
import json

pub fn about_subreddit(name string) !AboutSubreddit {
	mut resp := get('https://reddit.com/r/${name}/about.json') or {
		return error('Failed to get subreddit
		(${name})\'s information (https://reddit.com/r/${name}/about.json).
		\nOriginal ${err}')
	}

	if resp.status_code == 404 {
		return error('Failed to find subreddit (${name})\'s information (https://reddit.com/r/${name}/about.json)')
	}

	return json.decode(AboutSubreddit, resp.body)
}

struct AboutSubreddit {
pub:
	kind string
	data AboutSubredditData
}

struct AboutSubredditData {
pub:
	accept_followers bool
	accounts_active int
	accounts_active_is_fuzzed bool
	active_user_count bool
	advertiser_category string
	all_original_content bool
	allow_chat_post_creation bool
	allow_discovery bool
	allow_galleries bool
	allow_iamges bool
	allow_polls bool
	allow_prediction_contributors bool
allow_predictions_tournament bool
	allow_talks bool
	allow_videogifs bool
	allow_videos bool
	allow_media_in_comments []string
	banner_background_color string
	banner_background_image string
	banner_img string
	banner_size []int
	can_assign_link_flair bool
	can_assign_user_flair bool
	collapse_deleted_comments bool
	comment_contribution_settings  Subreddit_CommentContributionSettings
	comment_score_hide_mins int
	community_icon string
community_reviewed bool
	content_category string
	created int
	created_utc int
	description string
description_html string
	disable_contributor_requests bool
	display_name string
	display_name_prefixed string
	emojis_custom_size []int // TODO: maybe comment out cause no subreddits ive tested have this actually
	emojis_enabled bool
	free_form_reports bool
	has_menu_widget bool
	header_img string
	header_size []int
	header_title string
	hide_ads bool
	icon_img string
	icon_size []int
	id string
	is_chat_post_feature_enabled bool
	is_crosspostable_subreddit bool
	is_enrolled_in_new_modmail bool //nullable
	key_color string
	lang string
	link_flair_enabled bool
	link_flair_position string
	mobile_banner_iamge string
	name string
	// notification_level string -> TODO: no subreddits ive tested have this set to a value
	original_content_tag_enabled bool
	over18 bool
	prediction_leaderboard_entry_type string
	primary_color string
	public_description string
public_description_html string
public_traffic bool
	quarantine bool
	restrict_commenting bool
	restrict_posting bool
	should_achrive_posts bool
	should_show_media_in_comments_settings bool
	show_media bool
	show_media_preview bool
	spoilers_enabled bool
	submission_type string
submit_link_label string
	submit_text string
	submit_text_html string
	submit_text_label string
	subreddit_type string
	subscribers int
	// suggested_comment_sort TODO: find type
	title string
	url string
	user_can_flair_in_sr bool
	user_flair_background_color ?string
	user_flair_css_class ?string
	user_flair_enabled_in_sr bool
	user_flair_position ?string
	// user_flair_richtext [] TODO: find type
	user_flair_template_id ?string
	user_flair_text ?string
	user_flair_text_color ?string
	user_flair_type string
	user_has_favorited bool
	user_is_banned bool
	user_is_contributor bool
	user_is_moderator bool
	user_is_muted bool
	user_is_subscriber bool
	user_sr_flair_enabled bool
	user_sr_theme_enabled bool
	videostream_links_count int
	whitelist_status string
	wiki_enabled bool
	wls int
}

struct Subreddit_CommentContributionSettings {
	allowed_media_types []string
}


// about_user fetches a user from reddit, it pulls their /about.json and parses it into a V struct
pub fn about_user(name string) !User {
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
