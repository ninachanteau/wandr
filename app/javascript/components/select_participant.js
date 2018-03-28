  const participantsAvatar = document.querySelectorAll(".accommodation-participant-avatar");
  console.log("hello from js");
  if (participantsAvatar) {
    participantsAvatar.forEach((avatar) => {
      avatar.addEventListener('click', (e) => {
        console.log("hello from click");
        const targetId = avatar.dataset.participationId;
        console.log(document.getElementById(`accommodation_participations_pseudo_${targetId}`));
        document.getElementById(`accommodation_participations_pseudo_${targetId}`).click();
        avatar.classList.toggle('avatar-large-selected');
        // TODO modify avatar
      });
    });
  }

