# frozen_string_literal: true

module Users
  # InvitationsController
  class InvitationsController < Devise::InvitationsController
    private

    def invite_resource(&block)
      # instance method, invite!, returns a User instance
      resource_class.invite!(
        invite_params.merge(skip_invitation_params),
        current_inviter,
        &block
      )
    end

    def after_invite_path_for(_inviter, invitee)
      users_invitations_instructions_path(
        id: invitee.id,
        token: invitee.raw_invitation_token
      )
    end

    def skip_invitation_params
      {
        skip_invitation: true # don't send an email.
      }
    end
  end
end
