# frozen_string_literal: true

class PersonalitiesController < ApplicationController
  # user must be logged in to access any views
  before_action :require_login

  def index
    user_id = current_user.id
    @profile = Profile.find_by user_id: user_id
    #Redirects user to different pages depending on if they have a profile and their pt results
    if (@profile)
      render('indexFox') if @profile.ptanimal == 'The Compromising Fox'
    else
      redirect_to(root_path, { flash: { danger: 'Must create a profile to view this page' } })
    end
  end

  def indexFox; end

  def myersBriggs
    # Retrieves current user’s myer’s briggs personality type
    user_id = current_user.id
    @user_profile = Profile.find_by user_id: user_id
    mbptype = @user_profile.ptmyersbriggs
    # List of good and ideal matches for first 8 personality types
    top8 = %w[INFP ENFP INFJ ENFJ INTJ ENTJ INTP ENTP]
    # List of good and ideal matches for middle 4 personality types
    middle4 = %w[INTJ ENTJ INTP ENTP ISFJ ESFJ ISTJ ESTJ]
    # List of good and ideal matches for bottom 4 personality types
    bottom4 = %w[ISFJ ESFJ ISTJ ESTJ]

    def return_matches(matches)
      Profile.where(ptmyersbriggs: matches)
    end

    # Queries profile database with list of great matches, removes ideal matches from list
    def return_matches_double(matches1, matches2)
      matches2 -= matches1
      Profile.where(ptmyersbriggs: matches2)
    end

    case mbptype
    when 'INFP'
      ideal_matches = %w[ENFJ ENTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ENFP'
      ideal_matches = %w[INFJ INTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'INFJ'
      ideal_matches = %w[ENFP ENTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ENFJ'
      ideal_matches = %w[INFP ISFP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'INTJ'
      ideal_matches = %w[ENFP ENTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ENTJ'
      ideal_matches = %w[INFP INTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'INTP'
      ideal_matches = %w[ENTJ ESTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ENTP'
      ideal_matches = %w[INFJ INTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, top8)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ISFP'
      ideal_matches = %w[ENFJ ESFJ ESTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, middle4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ESFP'
      ideal_matches = %w[ISFJ ISTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, middle4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ISTP'
      ideal_matches = %w[ESFJ ESTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, middle4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ESTP'
      ideal_matches = %w[ISFJ ISTJ]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches_double(ideal_matches, middle4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ISFJ'
      ideal_matches = %w[ESFP ESTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches(bottom4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ESFJ'
      ideal_matches = %w[ISFP ISTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches(bottom4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ISTJ'
      ideal_matches = %w[ESFP ESTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches(bottom4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    when 'ESTJ'
      ideal_matches = %w[INTP ISFP ISTP]
      @ideal_matches = return_matches(ideal_matches)
      @good_matches = return_matches(bottom4)
      @good_matches = @good_matches.where.not(user_id: user_id)
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have MB test filled out to view this page.' } })
    end
  end

  def conflictManagement
    # Retrieves current user’s conflict management type
    user_id = current_user.id
    @user_profile = Profile.find_by user_id: user_id
    cr_type = @user_profile.ptanimal
    # Returns a list of users who have the same conflict animal as the user
    @same_cm = Profile.where(ptanimal: cr_type)
    @same_cm = @same_cm.where.not(user_id: user_id)
    # list of fox types as foxes can be paired with anybody
    @foxCM = Profile.where(ptanimal: 'The Compromising Fox')
    # Depending on the user's conflict animal, returns a list of users who have the opposite type
    case cr_type
    when 'The Competitive Shark'
      opposite_animal = ['The Accommodating Teddy Bear']
      @opposite_matches = Profile.where(ptanimal: opposite_animal)
      @message = 'As a Shark, your best matches are teddy bears!'
    when 'The Collaborative Owl'
      opposite_animal = ['The Avoidant Turtle']
      @opposite_matches = Profile.where(ptanimal: opposite_animal)
      @message = 'As an Owl, your best matches are turtles!'
    when 'The Avoidant Turtle'
      opposite_animal = ['The Collaborative Owl']
      @opposite_matches = Profile.where(ptanimal: opposite_animal)
      @message = 'As a Turtle, your best matches are owls!'
    when 'The Accommodating Teddy Bear'
      opposite_animal = ['The Competitive Shark']
      @opposite_matches = Profile.where(ptanimal: opposite_animal)
      @message = 'As a Teddy Bear, your best matches are sharks!'
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have result of Conflict Management test filled out to view this page.' } })
    end
  end

  def conflictManagementFox
    # Because foxes can match with all types of animals, they have their own page displaying all of them
    user_id = current_user.id
    @user_profile = Profile.find_by user_id: user_id
    cr_type = @user_profile.ptanimal
    # Returns a list of users who have the same conflict animal as the user
    @same_cm = Profile.where(ptanimal: cr_type)
    @same_cm = @same_cm.where.not(user_id: user_id)
    # Stores every animal outside of fox in their own arrays
    @sharks = Profile.where(ptanimal: 'The Competitive Shark')
    @owls = Profile.where(ptanimal: 'The Collaborative Owl')
    @turtles = Profile.where(ptanimal: 'The Avoidant Turtle')
    @bears = Profile.where(ptanimal: 'The Accommodating Teddy Bear')
    @message = 'As a Fox, you can match with anybody!'
  end

  def trueColors
    # Retrieves current user’s profile
    user_id = current_user.id
    @user_profile = Profile.find_by user_id: user_id
    userTC = @user_profile.pttruecolors
    # Because there is no defined compatibility online, will just query database for users of all types, and recommend the user checks out profiles with different types
    case userTC
    when 'Blue'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @other_profiles_1 = Profile.where(pttruecolors: 'Gold')
      @other_profiles_1color = 'Gold'
      @other_profiles_2 = Profile.where(pttruecolors: 'Green')
      @other_profiles_2color = 'Green'
      @other_profiles_3 = Profile.where(pttruecolors: 'Orange')
      @other_profiles_3color = 'Orange'
    when 'Gold'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @other_profiles_1 = Profile.where(pttruecolors: 'Blue')
      @other_profiles_1color = 'Blue'
      @other_profiles_2 = Profile.where(pttruecolors: 'Green')
      @other_profiles_2color = 'Green'
      @other_profiles_3 = Profile.where(pttruecolors: 'Orange')
      @other_profiles_3color = 'Orange'
    when 'Green'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @other_profiles_1 = Profile.where(pttruecolors: 'Blue')
      @other_profiles_1color = 'Blue'
      @other_profiles_2 = Profile.where(pttruecolors: 'Gold')
      @other_profiles_2color = 'Gold'
      @other_profiles_3 = Profile.where(pttruecolors: 'Orange')
      @other_profiles_3color = 'Orange'
    when 'Orange'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @other_profiles_1 = Profile.where(pttruecolors: 'Gold')
      @other_profiles_1color = 'Gold'
      @other_profiles_2 = Profile.where(pttruecolors: 'Green')
      @other_profiles_2color = 'Green'
      @other_profiles_3 = Profile.where(pttruecolors: 'Blue')
      @other_profiles_3color = 'Blue'
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have result of True Colors test filled out to view this page.' } })
    end
  end

  def enneagram
    # Retrieves current user's profile
    user_id = current_user.id
    @user_profile = Profile.find_by user_id: user_id
    # As enneagram test has a list of ideal matches, will be returning a list of the profiles that have the ideal personality type for the user
    userEnneagram = @user_profile.enneagram
    case userEnneagram
    when 'Reformer'
      # Type 1
      @m = 'Your ideal matches are Invidualists and Enthusiasts!'
      best_types = %w[Individualist Enthusiast]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Helper'
      # Type 2
      @m = 'Your ideal matches are Invidualists and Challengers!'
      best_types = %w[Individualist Challenger]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Achiever'
      # Type 3
      @m = 'Your ideal matches are Loyalists and Peacemakers!'
      best_types = %w[Loyalist Peacemaker]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Individualist'
      # Type 4
      @m = 'Your ideal matches are Reformers and Helpers!'
      best_types = %w[Reformer Helper]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Investigator'
      # Type 5
      @m = 'Your ideal matches are Enthusiasts and Challengers!'
      best_types = %w[Enthusiast Challenger]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Loyalist'
      # Type 6
      @m = 'Your ideal matches are Achievers and Peacemakers!'
      best_types = %w[Achiever Peacemaker]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Enthusiast'
      # Type 7
      @m = 'Your ideal matches are Reformers and Investigators!'
      best_types = %w[Reformer Investigator]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Challenger'
      # Type 8
      @m = 'Your ideal matches are Helpers and Investigators!'
      best_types = %w[Helper Investigator]
      @best_matches = Profile.where(enneagram: best_types)
    when 'Peacemaker'
      # Type 9
      @m = 'Your ideal matches are Acheivers and Loyalists!'
      best_types = %w[Achiever Loyalist]
      @best_matches = Profile.where(enneagram: best_types)
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have result of Enneagram test filled out to view this page.' } })
    end
  end
end
