module Helpers
  def admin_login
    # Sign up with a new account.
    visit root_path
    click_link 'Sign up'
    fill_in 'user[name]', with: 'Admin Name'
    fill_in 'user[email]', with: 'fcpartner123@gmail.com'
    fill_in 'Password', with: '12345'
    click_button 'Sign up'

    # Confirm the email.
    open_email 'fcpartner123@gmail.com'
    click_first_link_in_email
  end

  # Helper function to login a user and make them a Director (in order to access matches pages)
  def director_login
    # Sign up with a new account.
    visit root_path
    click_link 'Sign up'
    fill_in 'user[name]', with: 'Director Name'
    fill_in 'user[email]', with: 'director@gmail.com'
    fill_in 'Password', with: '12345'
    click_button 'Sign up'
  
    # Approve user
    @user = User.last
    @user.approved = TRUE
    @user.save
  
    # Make the last account that signed up a Director in order to access the matches pages.
    @director_user = User.last
    @director_user.remove_role :chair
    @director_user.add_role :director
  
    # Confirm the email.
    open_email 'director@gmail.com'
    click_first_link_in_email
  end

  def user_login
    # Sign up with new account
    visit root_path
    click_link 'Sign up'
    fill_in 'Name', with: 'User Name'
    fill_in 'user[email]', with: 'user@gmail.com'
    fill_in 'Password', with: '12345'
    click_button 'Sign up'
  
    #Approve user
    @user = User.last
    @user.approved = TRUE
    @user.save
  
    # Confirm the email
    open_email 'user@gmail.com'
    click_first_link_in_email
  end
end