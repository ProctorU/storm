module Users
  # InvitationsController
  class InvitationsController < Devise::InvitationsController
    layout('application')

    private

    def invite_resource
      # skip sending emails on invite.
      super do |u|
        u.skip_invitation = true
      end
    end

    def after_invite_path_for(_inviter, invitee)
      users_invitations_instructions_path(id: invitee.id)
    end
  end
end
