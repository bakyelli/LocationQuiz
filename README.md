# Objects

## Location

### Properties
	
	* (CLLocation) Coordinates
	* (NSString *) Name
	* (Quiz *)Quiz
	* (Address *)Address

### Methods
	
	none

## User

### Properties
	
	* (NSString *)firstName
	* (NSString *)lastName
	* (NSNumber *)correctAnswers
	* (NSNumber *)wrongAnswers

### Methods

	* (NSNumber *)questionsAnswered
	* (NSNumner *)percentageCorrect
	* (NSString *)fullName

## Quiz

### Properties
	
	* (NSArray *)cards
	* (Location *)location
	* (NSString *)name
	* (NSArray *)finishedUsers

### Methods
	* (BOOL)isCloseToCoordinate:(CLLocationCoordinate2D)coordinate
	* (id) initWithLocation:(Location *)location
	* (id) initWithLocation:(Location *)location andName:(NSString *)name
	* (void)moveCardFromIndex:(NSIndexPath *)fromIndexPath toIndex:(NSIndexPath *)toIndexPath
	* (NSNumber *)averageDifficulty
	* (Card *)randomCard

## Card

### Properties

	* (Question *)question
	* (NSArray *)answers
	* (NSNumber *)difficulty
	* (NSNumber *)order

### Methods
	
	* (NSArray *)randomizedAnswers

## Question

### Properties

	* (UIImage *) image
	* (NSString *) content
	* (NSData *) audio

## Answer

### Properties

	* (UIImage *) image
	* (NSString *) content
	* (NSData *) audio
	* (BOOL) isCorrect