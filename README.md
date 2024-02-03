# README
Video describing the project: https://www.loom.com/share/93b3e9345e9042b88013f80c92cd6de9

Follow this guide: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-ruby-on-rails-v7-project-with-a-react-frontend-on-ubuntu-20-04#step-6-creating-the-recipe-controller-and-model

Tech Stack: Ruby on Rails, React, PostgreSQL, TypeScript, Jest and Rspec (mirroring VTS tech stack at past company)

run ```bin/dev``` to start server, then visit http://localhost:3000/

run ```npm run check-types``` to check for TypeScript errors

run ```bundle exec rspec spec/.../..._spec.rb``` for backend unit testing

Imagine an auction system, where users can submit bids on the same item. In this auction, only one item is biddable at a time. The auction closes after 30 seconds, the starting bid is $1, bids are only in whole-dollar amounts, and the highest bidder when the auction closes wins.

Description of project:
A user can hit a button to open bidding and begin the auction. This user is the auctioneer. The auctioneer identifies the item with a name.
Other non-auctioneer users can hit a button to bid on the item. Hitting the button should place a new bid for that user at the current winning bid plus the current minimum increment.
The minimum increment is the previous power of ten. Example: if the current bid is $90, the next minimum bid is $91. If the current bid is $100, the next minimum bid is $110.
Users should see a confirmation their bid was placed successfully. Bids should be placed successfully if (1) the auction has not yet closed and (2) the bid exceeds the current minimum increment.
Users can see the current winning bid, whether that bid is theirs, and when the auction closes.
When the auction closes, users should be able to see the winning bid amount and if they won.
