platforms = {
  "PlayStation 3": 1,
  "PlayStation 4": 2,
  "PlayStation 5": 3,
  PC: 4,
  "Xbox 360": 5,
  "Xbox One": 6,
  "Xbox Series S": 7,
  "Xbox Series X": 8,
  "Nintendo Switch": 9,
};

runStatuses = {
  new: 0,
  verified: 1,
  rejected: 2,
};

// GTA V:          1
// The Witcher 3:  2
// ############
const game = 2;
// ############
let gameID;
let gameVersion;
switch (game) {
  case 1:
    gameID = "om1mx362";
    gameVersion = 1.64;
    break;
  case 2:
    gameID = "k6qre01g";
    gameVersion = 4.01;
    break;
}

// Any%:            1
// Segments:        2
// Hearts of Stone: 3
// ################
const category = 3;
// ################
let categoryID;
let secondLast;
switch (category) {
  case 1:
    if (game == 1) {
      categoryID = "wkpn1jdr";
      secondLast = 600;
    } else {
      categoryID = "jdr7j9n2";
      secondLast = 0;
    }
    break;
  case 2:
    if (game == 1) {
      categoryID = "7kjvmgk3";
      secondLast = 3400;
    } else {
      throw "This game does not have this category";
    }
    break;
  case 3:
    if (game == 2) {
      categoryID = "w201nqvk";
      secondLast = 0;
    } else {
      throw "This game does not have this category";
    }
}

async function getResults() {
  for (let off = 0; off <= 200; off += 200) {
    const response = await fetch(
      `https://www.speedrun.com/api/v1/runs?max=200&offset=${
        secondLast + off
      }&game=${gameID}&category=${categoryID}`
    );
    const data = await response.json();
    for (let i = 0; i < 200; i++) {
      if (data.data[i].system !== undefined) {
        let platform = await fetch(
          `https://www.speedrun.com/api/v1/platforms/${data.data[i].system.platform}`
        );
        platform = await platform.json();
        if (
          data.data[i].submitted !== null &&
          platforms[platform.data.name] !== undefined &&
          data.data[i].videos.links !== undefined
        ) {
          let verifiedBy;
          if (data.data[i].status.status == "new") {
            verifiedBy = null;
          } else {
            verifiedBy = Math.round(Math.random() + 1);
          }
          // console.log(data.data[i].status.status);
          console.log(
            `(${Math.round(Math.random() * 3 + 1)}, ${game}, ${category}, ${
              platforms[platform.data.name]
            }, 1, ${data.data[i].times.primary_t}, ${
              data.data[i].times.ingame_t
            }, ${gameVersion}, '${data.data[i].submitted}', '${
              data.data[i].videos.links[0].uri
            }', ${runStatuses[data.data[i].status.status]}, ${verifiedBy}),`
          );
        }
      }
    }
  }
}

getResults();
