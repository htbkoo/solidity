pragma solidity >=0.4.22 <=0.8.17;

abstract contract Game {
    // Write your code here
    string _homeTeam;
    string _awayTeam;
    constructor(string memory homeTeam, string memory awayTeam) {
        _homeTeam = homeTeam;
        _awayTeam = awayTeam;
    }

    function getHomeTeamScore() internal virtual returns (uint);

    function getAwayTeamScore() internal virtual returns (uint);

    function getWinningTeam() public returns (string memory) {
        uint homeTeamScore = getHomeTeamScore();
        uint awayTeamScore = getAwayTeamScore();

        if (homeTeamScore > awayTeamScore) {
            return _homeTeam;
        } else if (homeTeamScore > awayTeamScore) {
            return _awayTeam;
        } else {
            return _homeTeam;
        }
    }
}

contract BasketballGame is Game {
    // Write your code here
    constructor(string memory homeTeam, string memory awayTeam) Game(homeTeam, awayTeam) {
    }

    uint homeTeamScore;
    uint awayTeamScore;

    function getHomeTeamScore() internal view override returns (uint) {
        return homeTeamScore;
    }

    function getAwayTeamScore() internal view override returns (uint) {
        return awayTeamScore;
    }

    modifier isValidBasketballGameScore(uint score) {
        require(1 <= score && score <= 3);
        _;
    }

    function homeTeamScored(uint score) external isValidBasketballGameScore(score) {
        homeTeamScore += score;
    }
    function awayTeamScored(uint score) external isValidBasketballGameScore(score) {
        awayTeamScore += score;
    }
}

contract SoccerGame is Game {
    // Write your code here
    constructor(string memory homeTeam, string memory awayTeam) Game(homeTeam, awayTeam) {
    }

    uint homeTeamScore;
    uint awayTeamScore;

    function getHomeTeamScore() internal view override returns (uint) {
        return homeTeamScore;
    }

    function getAwayTeamScore() internal view override returns (uint) {
        return awayTeamScore;
    }

    function homeTeamScored() external {
        homeTeamScore++;
    }
    function awayTeamScored() external {
        awayTeamScore++;
    }
}
