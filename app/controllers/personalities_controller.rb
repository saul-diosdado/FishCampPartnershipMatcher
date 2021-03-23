# frozen_string_literal: true

class PersonalitiesController < ApplicationController
  # user must be logged in to access any views
  before_action :require_login

  def index
    user_id = current_user.id
    @profile = Profile.find_by user_id: user_id
    render('indexFox') if @profile.ptanimal == 'The Compromising Fox'
  end

  def indexFox; end

  def myersBriggs
    # Retrieves current user’s myer’s briggs personality type
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    mbptype = @userProfile.ptmyersbriggs
    # List of good and ideal matches for first 8 personality types
    top8 = %w[INFP ENFP INFJ ENFJ INTJ ENTJ INTP ENTP]
    # List of good and ideal matches for middle 4 personality types
    middle4 = %w[INTJ ENTJ INTP ENTP ISFJ ESFJ ISTJ ESTJ]
    # List of good and ideal matches for bottom 4 personality types
    bottom4 = %w[ISFJ ESFJ ISTJ ESTJ]

    def ReturnMatches(matches)
      Profile.where(ptmyersbriggs: matches)
    end

    # Queries profile database with list of great matches, removes ideal matches from list
    def ReturnMatchesDouble(matches1, matches2)
      matches2 -= matches1
      Profile.where(ptmyersbriggs: matches2)
    end

    case mbptype
    when 'INFP'
      idealMatches = %w[ENFJ ENTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ENFP'
      idealMatches = %w[INFJ INTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'INFJ'
      idealMatches = %w[ENFP ENTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ENFJ'
      idealMatches = %w[INFP ISFP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'INTJ'
      idealMatches = %w[ENFP ENTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ENTJ'
      idealMatches = %w[INFP INTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'INTP'
      idealMatches = %w[ENTJ ESTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ENTP'
      idealMatches = %w[INFJ INTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ISFP'
      idealMatches = %w[ENFJ ESFJ ESTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ESFP'
      idealMatches = %w[ISFJ ISTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ISTP'
      idealMatches = %w[ESFJ ESTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ESTP'
      idealMatches = %w[ISFJ ISTJ]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ISFJ'
      idealMatches = %w[ESFP ESTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ESFJ'
      idealMatches = %w[ISFP ISTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ISTJ'
      idealMatches = %w[ESFP ESTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    when 'ESTJ'
      idealMatches = %w[INTP ISFP ISTP]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      @goodMatches = @goodMatches.where.not(user_id: user_id)
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have MB test filled out to view this page.' } })
    end
  end

  def conflictManagement
    # Retrieves current user’s conflict management type
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    crType = @userProfile.ptanimal
    # Returns a list of users who have the same conflict animal as the user
    @sameCM = Profile.where(ptanimal: crType)
    @sameCM = @sameCM.where.not(user_id: user_id)
    # list of fox types as foxes can be paired with anybody
    @foxCM = Profile.where(ptanimal: 'The Compromising Fox')
    # Depending on the user's conflict animal, returns a list of users who have the opposite type
    case crType
    when 'The Competitive Shark'
      oppositeAnimal = ['The Accommodating Teddy Bear']
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = 'As a Shark, your best matches are teddy bears!'
    when 'The Collaborative Owl'
      oppositeAnimal = ['The Avoidant Turtle']
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = 'As an Owl, your best matches are turtles!'
    when 'The Avoidant Turtle'
      oppositeAnimal = ['The Collaborative Owl']
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = 'As a Turtle, your best matches are owls!'
    when 'The Accommodating Teddy Bear'
      oppositeAnimal = ['The Competitive Shark']
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = 'As a Teddy Bear, your best matches are sharks!'
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have result of Conflict Management test filled out to view this page.' } })
    end
  end

  def conflictManagementFox
    # Because foxes can match with all types of animals, they have their own page displaying all of them
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    crType = @userProfile.ptanimal
    # Returns a list of users who have the same conflict animal as the user
    @sameCM = Profile.where(ptanimal: crType)
    @sameCM = @sameCM.where.not(user_id: user_id)
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
    @userProfile = Profile.find_by user_id: user_id
    userTC = @userProfile.pttruecolors
    # Because there is no defined compatibility online, will just query database for users of all types, and recommend the user checks out profiles with different types
    case userTC
    when 'Blue'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @otherProfiles1 = Profile.where(pttruecolors: 'Gold')
      @otherProfiles1color = 'Gold'
      @otherProfiles2 = Profile.where(pttruecolors: 'Green')
      @otherProfiles2color = 'Green'
      @otherProfiles3 = Profile.where(pttruecolors: 'Orange')
      @otherProfiles3color = 'Orange'
    when 'Gold'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @otherProfiles1 = Profile.where(pttruecolors: 'Blue')
      @otherProfiles1color = 'Blue'
      @otherProfiles2 = Profile.where(pttruecolors: 'Green')
      @otherProfiles2color = 'Green'
      @otherProfiles3 = Profile.where(pttruecolors: 'Orange')
      @otherProfiles3color = 'Orange'
    when 'Green'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @otherProfiles1 = Profile.where(pttruecolors: 'Blue')
      @otherProfiles1color = 'Blue'
      @otherProfiles2 = Profile.where(pttruecolors: 'Gold')
      @otherProfiles2color = 'Gold'
      @otherProfiles3 = Profile.where(pttruecolors: 'Orange')
      @otherProfiles3color = 'Orange'
    when 'Orange'
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @sameProfiles = @sameProfiles.where.not(user_id: user_id)
      @otherProfiles1 = Profile.where(pttruecolors: 'Gold')
      @otherProfiles1color = 'Gold'
      @otherProfiles2 = Profile.where(pttruecolors: 'Green')
      @otherProfiles2color = 'Green'
      @otherProfiles3 = Profile.where(pttruecolors: 'Blue')
      @otherProfiles3color = 'Blue'
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have result of True Colors test filled out to view this page.' } })
    end
  end

  def enneagram
    # Retrieves current user's profile
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    # As enneagram test has a list of ideal matches, will be returning a list of the profiles that have the ideal personality type for the user
    userEnneagram = @userProfile.enneagram
    case userEnneagram
    when 'Reformer'
      # Type 1
      @m = 'Your ideal matches are Invidualists and Enthusiasts!'
      bestTypes = %w[Individualist Enthusiast]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Helper'
      # Type 2
      @m = 'Your ideal matches are Invidualists and Challengers!'
      bestTypes = %w[Individualist Challenger]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Achiever'
      # Type 3
      @m = 'Your ideal matches are Loyalists and Peacemakers!'
      bestTypes = %w[Loyalist Peacemaker]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Individualist'
      # Type 4
      @m = 'Your ideal matches are Reformers and Helpers!'
      bestTypes = %w[Reformer Helper]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Investigator'
      # Type 5
      @m = 'Your ideal matches are Enthusiasts and Challengers!'
      bestTypes = %w[Enthusiast Challenger]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Loyalist'
      # Type 6
      @m = 'Your ideal matches are Achievers and Peacemakers!'
      bestTypes = %w[Achiever Peacemaker]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Enthusiast'
      # Type 7
      @m = 'Your ideal matches are Reformers and Investigators!'
      bestTypes = %w[Reformer Investigator]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Challenger'
      # Type 8
      @m = 'Your ideal matches are Helpers and Investigators!'
      bestTypes = %w[Helper Investigator]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when 'Peacemaker'
      # Type 9
      @m = 'Your ideal matches are Acheivers and Loyalists!'
      bestTypes = %w[Achiever Loyalist]
      @bestMatches = Profile.where(enneagram: bestTypes)
    else
      redirect_to(personalities_path, { flash: { red: 'Profile must have result of Enneagram test filled out to view this page.' } })
    end
  end
end
