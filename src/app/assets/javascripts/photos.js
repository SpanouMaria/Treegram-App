// Function to show the slides in a slideshow container
function showSlides(n, container) {
    const slides = container.querySelectorAll(".mySlides");
    const titles = container.querySelectorAll(".photo-title");

    if (slides.length === 0) return;

    let slideIndex = parseInt(container.getAttribute("data-slide-index")) || 0;

    slideIndex = (slideIndex + n + slides.length) % slides.length;

    slides.forEach((slide, i) => {
        slide.style.display = i === slideIndex ? "block" : "none";
    });

    titles.forEach((title, i) => {
        title.style.display = i === slideIndex ? "block" : "none";
    });

    container.setAttribute("data-slide-index", slideIndex);
}

// Function to start auto-sliding the slideshow
function startAutoSlide(container) {
    if (container.autoSlideTimer) return;

    const comments = container.querySelector(".photo-comments");
    if (comments) comments.style.display = "none"; // Hide comments when slideshow starts

    container.autoSlideTimer = setInterval(() => {
        showSlides(1, container);
    }, 3000);
}

// Function to stop auto-sliding the slideshow
function stopAutoSlide(container) {
    clearInterval(container.autoSlideTimer);
    container.autoSlideTimer = null;

    const comments = container.querySelector(".photo-comments");
    if (comments) comments.style.display = "block"; // Show comments when slideshow stops

    const initialIndex = parseInt(container.getAttribute("data-initial-index")) || 0;
    container.setAttribute("data-slide-index", initialIndex);
    showSlides(0, container);
}

// Function to open the comment modal for a specific photo
function openCommentModal(photoId) {
    const modal = document.getElementById("comment-modal");
    const modalComments = document.getElementById("modal-comments");
    const photoIdField = document.getElementById("photo-id-field");

    photoIdField.value = photoId;

    modalComments.innerHTML = "Loading comments...";
    fetch(`/photos/${photoId}/comments`, {
        method: "GET",
        headers: { "X-Requested-With": "XMLHttpRequest", "Content-Type": "application/json" },
    })
        .then((response) => response.json())
        .then((comments) => {
            modalComments.innerHTML = "";
            comments.forEach((comment) => {
                const commentElement = document.createElement("p");
                commentElement.innerHTML = `<strong>${comment.user.email}:</strong> ${comment.text}`;
                modalComments.appendChild(commentElement);
            });
        });

    const slideshowContainer = document.querySelector(`[data-photo-id="${photoId}"]`);
    if (slideshowContainer) stopAutoSlide(slideshowContainer);

    modal.style.display = "block";
}

// Function to close the comment modal
function closeCommentModal() {
    const modal = document.getElementById("comment-modal");
    modal.style.display = "none";

    const slideshowContainer = document.querySelector(".slideshow-container:hover");
    if (slideshowContainer) startAutoSlide(slideshowContainer);
}

// Run this code once the document is fully loaded
document.addEventListener("DOMContentLoaded", () => {
    const slideshowContainers = document.querySelectorAll(".slideshow-container");

    slideshowContainers.forEach((container) => {
        const initialIndex = parseInt(container.getAttribute("data-slide-index")) || 0;
        container.setAttribute("data-slide-index", initialIndex);
        container.setAttribute("data-initial-index", initialIndex);
        showSlides(0, container);

        container.addEventListener("mouseenter", () => startAutoSlide(container));
        container.addEventListener("mouseleave", () => stopAutoSlide(container));

        const comments = container.querySelector(".photo-comments");

        if (comments) {
            comments.addEventListener("mouseenter", () => {
                stopAutoSlide(container); // Stop auto-slide while hovering over comments
                comments.style.display = "block"; // Ensure comments remain visible
            });

            comments.addEventListener("mouseleave", () => {
                startAutoSlide(container); // Resume auto-slide when leaving comments
            });
        }
    });

    document.querySelectorAll(".photo-image").forEach((image) => {
        const isCurrentUser = image.dataset.currentUser === "true";

        if (!isCurrentUser) {
            image.addEventListener("click", (event) => {
                const photoId = event.currentTarget.dataset.photoId;
                openCommentModal(photoId);
            });
        }

        if (isCurrentUser) {
            image.addEventListener("dblclick", (event) => {
                const photoId = event.currentTarget.dataset.photoId;

                if (confirm("Are you sure you want to delete this photo?")) {
                    fetch(`/photos/${photoId}`, {
                        method: "DELETE",
                        headers: {
                            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
                            "X-Requested-With": "XMLHttpRequest",
                        },
                    })
                        .then((response) => {
                            if (response.ok) {
                                const container = event.currentTarget.closest(".slideshow-container");
                                if (container) container.remove();
                                alert("Photo deleted successfully.");
                            } else {
                                alert("Failed to delete the photo. Please try again.");
                            }
                        })
                        .catch((error) => {
                            console.error("Error:", error);
                            alert("An error occurred. Please try again.");
                        });
                }
            });
        }
    });

    const closeBtn = document.querySelector(".close-btn");
    closeBtn.addEventListener("click", closeCommentModal);
});