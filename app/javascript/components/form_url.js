function RefreshForm() {
  const urlForm = document.getElementById("url-form");
  if (urlForm) {
    urlForm.addEventListener("change", function() {
    urlForm.parentElement.submit();

    })
  }
}

export {RefreshForm}
