// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Comfirm`
  String get Comfirm {
    return Intl.message(
      'Comfirm',
      name: 'Comfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get Show {
    return Intl.message(
      'Show',
      name: 'Show',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get Hide {
    return Intl.message(
      'Hide',
      name: 'Hide',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get auto {
    return Intl.message(
      'Auto',
      name: 'auto',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Follow System`
  String get Follow_System {
    return Intl.message(
      'Follow System',
      name: 'Follow_System',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get Light {
    return Intl.message(
      'Light',
      name: 'Light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get Dark {
    return Intl.message(
      'Dark',
      name: 'Dark',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get Setting {
    return Intl.message(
      'Setting',
      name: 'Setting',
      desc: '',
      args: [],
    );
  }

  /// `Theme Style`
  String get Theme_Style {
    return Intl.message(
      'Theme Style',
      name: 'Theme_Style',
      desc: '',
      args: [],
    );
  }

  /// `Theme Color`
  String get Theme_Color {
    return Intl.message(
      'Theme Color',
      name: 'Theme_Color',
      desc: '',
      args: [],
    );
  }

  /// `Default Color`
  String get Default_Color {
    return Intl.message(
      'Default Color',
      name: 'Default_Color',
      desc: '',
      args: [],
    );
  }

  /// `Custom Color`
  String get Custom_Color {
    return Intl.message(
      'Custom Color',
      name: 'Custom_Color',
      desc: '',
      args: [],
    );
  }

  /// `Image Compress`
  String get Image_Compress {
    return Intl.message(
      'Image Compress',
      name: 'Image_Compress',
      desc: '',
      args: [],
    );
  }

  /// `Don't Compress`
  String get Dont_Compress {
    return Intl.message(
      'Don\'t Compress',
      name: 'Dont_Compress',
      desc: '',
      args: [],
    );
  }

  /// `Font Family`
  String get Font_Family {
    return Intl.message(
      'Font Family',
      name: 'Font_Family',
      desc: '',
      args: [],
    );
  }

  /// `Default Font Family`
  String get Default_Font_Family {
    return Intl.message(
      'Default Font Family',
      name: 'Default_Font_Family',
      desc: '',
      args: [],
    );
  }

  /// `Custom Font Family`
  String get Custom_Font_Family {
    return Intl.message(
      'Custom Font Family',
      name: 'Custom_Font_Family',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Lock`
  String get Privacy_Lock {
    return Intl.message(
      'Privacy Lock',
      name: 'Privacy_Lock',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Face`
  String get Face {
    return Intl.message(
      'Face',
      name: 'Face',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint`
  String get Fingerprint {
    return Intl.message(
      'Fingerprint',
      name: 'Fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate to turn off the privacy lock`
  String get Please_authenticate_to_turn_off_the_privacy_lock {
    return Intl.message(
      'Please authenticate to turn off the privacy lock',
      name: 'Please_authenticate_to_turn_off_the_privacy_lock',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate to turn on the privacy lock`
  String get Please_authenticate_to_turn_on_the_privacy_lock {
    return Intl.message(
      'Please authenticate to turn on the privacy lock',
      name: 'Please_authenticate_to_turn_on_the_privacy_lock',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate to use app`
  String get Please_authenticate_to_use_app {
    return Intl.message(
      'Please authenticate to use app',
      name: 'Please_authenticate_to_use_app',
      desc: '',
      args: [],
    );
  }

  /// `Authenticat need`
  String get Authenticat_need {
    return Intl.message(
      'Authenticat need',
      name: 'Authenticat_need',
      desc: '',
      args: [],
    );
  }

  /// `Verify error`
  String get Verify_error {
    return Intl.message(
      'Verify error',
      name: 'Verify_error',
      desc: '',
      args: [],
    );
  }

  /// `Verify failure`
  String get Verify_failure {
    return Intl.message(
      'Verify failure',
      name: 'Verify_failure',
      desc: '',
      args: [],
    );
  }

  /// `Default index`
  String get Default_index {
    return Intl.message(
      'Default index',
      name: 'Default_index',
      desc: '',
      args: [],
    );
  }

  /// `Timeline`
  String get Timeline {
    return Intl.message(
      'Timeline',
      name: 'Timeline',
      desc: '',
      args: [],
    );
  }

  /// `Global`
  String get Global {
    return Intl.message(
      'Global',
      name: 'Global',
      desc: '',
      args: [],
    );
  }

  /// `Default tab`
  String get Default_tab {
    return Intl.message(
      'Default tab',
      name: 'Default_tab',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get Posts {
    return Intl.message(
      'Posts',
      name: 'Posts',
      desc: '',
      args: [],
    );
  }

  /// `Posts & Replies`
  String get Posts_and_replies {
    return Intl.message(
      'Posts & Replies',
      name: 'Posts_and_replies',
      desc: '',
      args: [],
    );
  }

  /// `Mentions`
  String get Mentions {
    return Intl.message(
      'Mentions',
      name: 'Mentions',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get Notes {
    return Intl.message(
      'Notes',
      name: 'Notes',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get Users {
    return Intl.message(
      'Users',
      name: 'Users',
      desc: '',
      args: [],
    );
  }

  /// `Topics`
  String get Topics {
    return Intl.message(
      'Topics',
      name: 'Topics',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get Request {
    return Intl.message(
      'Request',
      name: 'Request',
      desc: '',
      args: [],
    );
  }

  /// `Link preview`
  String get Link_preview {
    return Intl.message(
      'Link preview',
      name: 'Link_preview',
      desc: '',
      args: [],
    );
  }

  /// `Video preview in list`
  String get Video_preview_in_list {
    return Intl.message(
      'Video preview in list',
      name: 'Video_preview_in_list',
      desc: '',
      args: [],
    );
  }

  /// `Network`
  String get Network {
    return Intl.message(
      'Network',
      name: 'Network',
      desc: '',
      args: [],
    );
  }

  /// `The network will take effect the next time the app is launched`
  String get network_take_effect_tip {
    return Intl.message(
      'The network will take effect the next time the app is launched',
      name: 'network_take_effect_tip',
      desc: '',
      args: [],
    );
  }

  /// `Image service`
  String get Image_service {
    return Intl.message(
      'Image service',
      name: 'Image_service',
      desc: '',
      args: [],
    );
  }

  /// `Forbid image`
  String get Forbid_image {
    return Intl.message(
      'Forbid image',
      name: 'Forbid_image',
      desc: '',
      args: [],
    );
  }

  /// `Forbid video`
  String get Forbid_video {
    return Intl.message(
      'Forbid video',
      name: 'Forbid_video',
      desc: '',
      args: [],
    );
  }

  /// `Please input`
  String get Please_input {
    return Intl.message(
      'Please input',
      name: 'Please_input',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get Notice {
    return Intl.message(
      'Notice',
      name: 'Notice',
      desc: '',
      args: [],
    );
  }

  /// `Write a message`
  String get Write_a_message {
    return Intl.message(
      'Write a message',
      name: 'Write_a_message',
      desc: '',
      args: [],
    );
  }

  /// `Add to known list`
  String get Add_to_known_list {
    return Intl.message(
      'Add to known list',
      name: 'Add_to_known_list',
      desc: '',
      args: [],
    );
  }

  /// `Buy me a coffee!`
  String get Buy_me_a_coffee {
    return Intl.message(
      'Buy me a coffee!',
      name: 'Buy_me_a_coffee',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get Donate {
    return Intl.message(
      'Donate',
      name: 'Donate',
      desc: '',
      args: [],
    );
  }

  /// `What's happening?`
  String get What_s_happening {
    return Intl.message(
      'What\'s happening?',
      name: 'What_s_happening',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Send {
    return Intl.message(
      'Send',
      name: 'Send',
      desc: '',
      args: [],
    );
  }

  /// `Please input event id`
  String get Please_input_event_id {
    return Intl.message(
      'Please input event id',
      name: 'Please_input_event_id',
      desc: '',
      args: [],
    );
  }

  /// `Please input user pubkey`
  String get Please_input_user_pubkey {
    return Intl.message(
      'Please input user pubkey',
      name: 'Please_input_user_pubkey',
      desc: '',
      args: [],
    );
  }

  /// `Please input lnbc text`
  String get Please_input_lnbc_text {
    return Intl.message(
      'Please input lnbc text',
      name: 'Please_input_lnbc_text',
      desc: '',
      args: [],
    );
  }

  /// `Please input Topic text`
  String get Please_input_Topic_text {
    return Intl.message(
      'Please input Topic text',
      name: 'Please_input_Topic_text',
      desc: '',
      args: [],
    );
  }

  /// `Text can't contain blank space`
  String get Text_can_t_contain_blank_space {
    return Intl.message(
      'Text can\'t contain blank space',
      name: 'Text_can_t_contain_blank_space',
      desc: '',
      args: [],
    );
  }

  /// `Text can't contain new line`
  String get Text_can_t_contain_new_line {
    return Intl.message(
      'Text can\'t contain new line',
      name: 'Text_can_t_contain_new_line',
      desc: '',
      args: [],
    );
  }

  /// `replied`
  String get replied {
    return Intl.message(
      'replied',
      name: 'replied',
      desc: '',
      args: [],
    );
  }

  /// `boosted`
  String get boosted {
    return Intl.message(
      'boosted',
      name: 'boosted',
      desc: '',
      args: [],
    );
  }

  /// `liked`
  String get liked {
    return Intl.message(
      'liked',
      name: 'liked',
      desc: '',
      args: [],
    );
  }

  /// `key has been copy!`
  String get key_has_been_copy {
    return Intl.message(
      'key has been copy!',
      name: 'key_has_been_copy',
      desc: '',
      args: [],
    );
  }

  /// `Input dirtyword.`
  String get Input_dirtyword {
    return Intl.message(
      'Input dirtyword.',
      name: 'Input_dirtyword',
      desc: '',
      args: [],
    );
  }

  /// `Word can't be null.`
  String get Word_can_t_be_null {
    return Intl.message(
      'Word can\'t be null.',
      name: 'Word_can_t_be_null',
      desc: '',
      args: [],
    );
  }

  /// `Blocks`
  String get Blocks {
    return Intl.message(
      'Blocks',
      name: 'Blocks',
      desc: '',
      args: [],
    );
  }

  /// `Dirtywords`
  String get Dirtywords {
    return Intl.message(
      'Dirtywords',
      name: 'Dirtywords',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get loading {
    return Intl.message(
      'loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Account Manager`
  String get Account_Manager {
    return Intl.message(
      'Account Manager',
      name: 'Account_Manager',
      desc: '',
      args: [],
    );
  }

  /// `Add Account`
  String get Add_Account {
    return Intl.message(
      'Add Account',
      name: 'Add_Account',
      desc: '',
      args: [],
    );
  }

  /// `Input account private key`
  String get Input_account_private_key {
    return Intl.message(
      'Input account private key',
      name: 'Input_account_private_key',
      desc: '',
      args: [],
    );
  }

  /// `Add account and login?`
  String get Add_account_and_login {
    return Intl.message(
      'Add account and login?',
      name: 'Add_account_and_login',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get Filter {
    return Intl.message(
      'Filter',
      name: 'Filter',
      desc: '',
      args: [],
    );
  }

  /// `Relays`
  String get Relays {
    return Intl.message(
      'Relays',
      name: 'Relays',
      desc: '',
      args: [],
    );
  }

  /// `Key Backup`
  String get Key_Backup {
    return Intl.message(
      'Key Backup',
      name: 'Key_Backup',
      desc: '',
      args: [],
    );
  }

  /// `Please do not disclose or share the key to anyone.`
  String get Please_do_not_disclose_or_share_the_key_to_anyone {
    return Intl.message(
      'Please do not disclose or share the key to anyone.',
      name: 'Please_do_not_disclose_or_share_the_key_to_anyone',
      desc: '',
      args: [],
    );
  }

  /// `Nostromo developers will never require a key from you.`
  String get Nostromo_developers_will_never_require_a_key_from_you {
    return Intl.message(
      'Nostromo developers will never require a key from you.',
      name: 'Nostromo_developers_will_never_require_a_key_from_you',
      desc: '',
      args: [],
    );
  }

  /// `Please keep the key properly for account recovery.`
  String get Please_keep_the_key_properly_for_account_recovery {
    return Intl.message(
      'Please keep the key properly for account recovery.',
      name: 'Please_keep_the_key_properly_for_account_recovery',
      desc: '',
      args: [],
    );
  }

  /// `Backup and Safety tips`
  String get Backup_and_Safety_tips {
    return Intl.message(
      'Backup and Safety tips',
      name: 'Backup_and_Safety_tips',
      desc: '',
      args: [],
    );
  }

  /// `The key is a random string that resembles your account password. Anyone with this key can access and control your account.`
  String get The_key_is_a_random_string_that_resembles_ {
    return Intl.message(
      'The key is a random string that resembles your account password. Anyone with this key can access and control your account.',
      name: 'The_key_is_a_random_string_that_resembles_',
      desc: '',
      args: [],
    );
  }

  /// `Copy Key`
  String get Copy_Key {
    return Intl.message(
      'Copy Key',
      name: 'Copy_Key',
      desc: '',
      args: [],
    );
  }

  /// `Copy Hex Key`
  String get Copy_Hex_Key {
    return Intl.message(
      'Copy Hex Key',
      name: 'Copy_Hex_Key',
      desc: '',
      args: [],
    );
  }

  /// `Please check the tips.`
  String get Please_check_the_tips {
    return Intl.message(
      'Please check the tips.',
      name: 'Please_check_the_tips',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Generate a new private key`
  String get Generate_a_new_private_key {
    return Intl.message(
      'Generate a new private key',
      name: 'Generate_a_new_private_key',
      desc: '',
      args: [],
    );
  }

  /// `I accept the`
  String get I_accept_the {
    return Intl.message(
      'I accept the',
      name: 'I_accept_the',
      desc: '',
      args: [],
    );
  }

  /// `terms of user`
  String get terms_of_user {
    return Intl.message(
      'terms of user',
      name: 'terms_of_user',
      desc: '',
      args: [],
    );
  }

  /// `Private key is null.`
  String get Private_key_is_null {
    return Intl.message(
      'Private key is null.',
      name: 'Private_key_is_null',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the terms.`
  String get Please_accept_the_terms {
    return Intl.message(
      'Please accept the terms.',
      name: 'Please_accept_the_terms',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Display Name`
  String get Display_Name {
    return Intl.message(
      'Display Name',
      name: 'Display_Name',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get About {
    return Intl.message(
      'About',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `Picture`
  String get Picture {
    return Intl.message(
      'Picture',
      name: 'Picture',
      desc: '',
      args: [],
    );
  }

  /// `Banner`
  String get Banner {
    return Intl.message(
      'Banner',
      name: 'Banner',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get Website {
    return Intl.message(
      'Website',
      name: 'Website',
      desc: '',
      args: [],
    );
  }

  /// `Nip05`
  String get Nip05 {
    return Intl.message(
      'Nip05',
      name: 'Nip05',
      desc: '',
      args: [],
    );
  }

  /// `Lud16`
  String get Lud16 {
    return Intl.message(
      'Lud16',
      name: 'Lud16',
      desc: '',
      args: [],
    );
  }

  /// `Input relay address.`
  String get Input_relay_address {
    return Intl.message(
      'Input relay address.',
      name: 'Input_relay_address',
      desc: '',
      args: [],
    );
  }

  /// `Address can't be null.`
  String get Address_can_t_be_null {
    return Intl.message(
      'Address can\'t be null.',
      name: 'Address_can_t_be_null',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Empty text may be ban by relays.`
  String get Empty_text_may_be_ban_by_relays {
    return Intl.message(
      'Empty text may be ban by relays.',
      name: 'Empty_text_may_be_ban_by_relays',
      desc: '',
      args: [],
    );
  }

  /// `Note loading...`
  String get Note_loading {
    return Intl.message(
      'Note loading...',
      name: 'Note_loading',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get Following {
    return Intl.message(
      'Following',
      name: 'Following',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get Read {
    return Intl.message(
      'Read',
      name: 'Read',
      desc: '',
      args: [],
    );
  }

  /// `Write`
  String get Write {
    return Intl.message(
      'Write',
      name: 'Write',
      desc: '',
      args: [],
    );
  }

  /// `Copy current Url`
  String get Copy_current_Url {
    return Intl.message(
      'Copy current Url',
      name: 'Copy_current_Url',
      desc: '',
      args: [],
    );
  }

  /// `Copy init Url`
  String get Copy_init_Url {
    return Intl.message(
      'Copy init Url',
      name: 'Copy_init_Url',
      desc: '',
      args: [],
    );
  }

  /// `Open in browser`
  String get Open_in_browser {
    return Intl.message(
      'Open in browser',
      name: 'Open_in_browser',
      desc: '',
      args: [],
    );
  }

  /// `Copy success!`
  String get Copy_success {
    return Intl.message(
      'Copy success!',
      name: 'Copy_success',
      desc: '',
      args: [],
    );
  }

  /// `Boost`
  String get Boost {
    return Intl.message(
      'Boost',
      name: 'Boost',
      desc: '',
      args: [],
    );
  }

  /// `Replying`
  String get Replying {
    return Intl.message(
      'Replying',
      name: 'Replying',
      desc: '',
      args: [],
    );
  }

  /// `Copy Note Json`
  String get Copy_Note_Json {
    return Intl.message(
      'Copy Note Json',
      name: 'Copy_Note_Json',
      desc: '',
      args: [],
    );
  }

  /// `Copy Note Pubkey`
  String get Copy_Note_Pubkey {
    return Intl.message(
      'Copy Note Pubkey',
      name: 'Copy_Note_Pubkey',
      desc: '',
      args: [],
    );
  }

  /// `Copy Note Id`
  String get Copy_Note_Id {
    return Intl.message(
      'Copy Note Id',
      name: 'Copy_Note_Id',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get Detail {
    return Intl.message(
      'Detail',
      name: 'Detail',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get Share {
    return Intl.message(
      'Share',
      name: 'Share',
      desc: '',
      args: [],
    );
  }

  /// `Broadcase`
  String get Broadcase {
    return Intl.message(
      'Broadcase',
      name: 'Broadcase',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get Block {
    return Intl.message(
      'Block',
      name: 'Block',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Metadata can not be found.`
  String get Metadata_can_not_be_found {
    return Intl.message(
      'Metadata can not be found.',
      name: 'Metadata_can_not_be_found',
      desc: '',
      args: [],
    );
  }

  /// `not found`
  String get not_found {
    return Intl.message(
      'not found',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `Gen invoice code error.`
  String get Gen_invoice_code_error {
    return Intl.message(
      'Gen invoice code error.',
      name: 'Gen_invoice_code_error',
      desc: '',
      args: [],
    );
  }

  /// `Notices`
  String get Notices {
    return Intl.message(
      'Notices',
      name: 'Notices',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
