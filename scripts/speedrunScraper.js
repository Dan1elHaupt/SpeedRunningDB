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

// const game = "om1mx362"; //GTA V
const game = "k6qre01g"; //The Witcher 3

// const category = "wkpn1jdr"; //Any% GTA V
const category = "jdr7j9n2"; //Any% Witcher 3

async function getResults() {
  const response = await fetch(
    `https://www.speedrun.com/api/v1/runs?max=200&offset=0&game=${game}&category=${category}`
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
        // console.log(data.data[i]);
        console.log(
          `(${Math.round(Math.random() * 3 + 1)}, 2, 1, ${
            platforms[platform.data.name]
          }, 1, ${data.data[i].times.primary_t}, ${
            data.data[i].times.ingame_t
          }, 4.01, '${data.data[i].submitted}', '${
            data.data[i].videos.links[0].uri
          }', ${data.data[i].status.status == "verified" ? 1 : 0}),`
        );
      }
    }
  }
}

getResults();
