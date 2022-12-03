// Enable particles.js
window.onload = function () {
  Particles.init({
    // normal options
    selector: ".background",
    maxParticles: 200,
    // options for breakpoints
    responsive: [
      {
        breakpoint: 768,
        options: {
          maxParticles: 100,
          connectParticles: false,
        },
      },
    ],
  });
};

// Intro Banner Setup
const introChangerPrevs = document.querySelectorAll(".intro__changer--prev");
const introChangerNexts = document.querySelectorAll(".intro__changer--next");
const introContainer = document.querySelector(".intro__container");
const introLength = document.querySelectorAll(".intro__item").length;
const introProgressBar = document.querySelector(".intro__progress-bar");

let currentIntro = 1;
console.log(introContainer);
introContainer.style.width = introLength * 100 + "vw";

function reset_animation(element) {
  element.style.animation = "none";
  element.offsetHeight;
  element.style.animation = null;
}

introChangerPrevs.forEach((prev, index) => {
  prev.addEventListener("click", () => {
    if (index + 1 == 1) {
      introContainer.style.transform =
        "translate(-" + (introLength - 1) * 100 + "vw)";
      currentIntro = introLength;
    } else {
      introContainer.style.transform =
        "translate(-" + (index - 1) * 100 + "vw)";
      currentIntro--;
    }
    clearInterval(introInterval);
    introInterval = setInterval(introIntervalFunc, 10000);
    reset_animation(introProgressBar);
  });
});

introChangerNexts.forEach((next, index) => {
  next.addEventListener("click", () => {
    if (index + 1 == introLength) {
      introContainer.style.transform = "translate(0)";
      currentIntro = 1;
    } else {
      introContainer.style.transform =
        "translate(-" + (index + 1) * 100 + "vw)";
      currentIntro++;
    }
    clearInterval(introInterval);
    introInterval = setInterval(introIntervalFunc, 10000);
    reset_animation(introProgressBar);
  });
});

function introIntervalFunc() {
  reset_animation(introProgressBar);
  if (currentIntro == introLength) {
    introContainer.style.transform = "translate(0)";
    currentIntro = 1;
  } else {
    introContainer.style.transform = `translate(-${currentIntro * 100}vw)`;
    currentIntro++;
  }
}

let introInterval = setInterval(introIntervalFunc, 10000);

// Enable clock
function setTime() {
  const date = new Date();
  let AM_PM;
  let hours = date.getHours();
  if (hours == 0) {
		AM_PM = "AM";
		hours = 12;
	} else if (hours < 12) {
    AM_PM = "AM";
  } else if (hours == 12) {
    AM_PM = "PM";
    hours = 12;
  } else {
    AM_PM = "PM";
    hours = hours % 12;
  }
  hours = hours.toString().padStart(2, "0");
  const minutes = date.getMinutes().toString().padStart(2, "0");
  const seconds = date.getSeconds().toString().padStart(2, "0");
  const clock = document.querySelector(".welcome__clock");
  clock.innerHTML = AM_PM + " " + hours + " : " + minutes + " : " + seconds;
}
setTime();
setInterval(setTime, 1000);
