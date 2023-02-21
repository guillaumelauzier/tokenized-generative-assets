# tokenized-generative-assets

The supply chain of tokenized generative assets can involve several steps, which may include the following:

- Data extraction: The process of collecting data from various sources, such as weather data, social media data, or financial data, to be used as input for the generative algorithm.
- Data providers: The companies or organizations that provide the data, such as weather services, social media platforms, or financial institutions.
- Generative algorithm: The computer program or algorithm that uses the input data to generate the artwork.
- Creation: The generative artwork is created using the algorithm, and the digital artwork is stored on a computer or server.
- Tokenization: The digital artwork is converted into a non-fungible token (NFT) that is recorded on a blockchain. The NFT serves as a digital certificate of ownership for the artwork, and it can be bought, sold, and traded on various online marketplaces.
- Listing: The NFT is listed for sale on various online marketplaces, such as OpenSea, SuperRare, or Nifty Gateway. The listing includes information about the artwork, such as the artist, the number of copies available, and any special features or attributes.
- Sale: The NFT is purchased by a buyer, who receives the digital certificate of ownership for the artwork. The buyer may keep the artwork or resell it on a secondary market.
- Storage and delivery: The digital artwork and the NFT are stored in a digital wallet, which can be accessed by the owner using a private key. If the artwork is physical, it may need to be stored or delivered to the buyer.
- Royalty payments: If the artwork is sold again in the future, the original artist may be entitled to a percentage of the sale price as a royalty payment, which can be automatically programmed into the smart contract associated with the NFT.
- Impact investors who invest in NFTs can generate monetized digital assets through the purchase of tokenized generative artworks. Institutions that buy these NFTs may use the resulting profits to invest in activities that support the initial philanthropic cause, such as environmental or social initiatives. Examples of such institutions include museums, galleries, or private collectors who may choose to display the artwork or keep it as an investment. By investing in NFTs, these institutions can not only support philanthropic causes, but also potentially benefit financially from their investment.

The exact supply chain may vary depending on the specific platform or marketplace used for the sale of the tokenized generative asset, as well as the specific data sources and generative algorithms used to create the artwork.

# Code explained

- dataprovider.sol contract allows authorized data providers to provide geographic data of food supply by calling the provideData function and sending the specified amount of ether as payment. The contract owner can set the price per data using the setPricePerData function and add or remove authorized providers using the addAuthorizedProvider and removeAuthorizedProvider functions. The withdraw function allows the owner to withdraw the balance of ether stored in the contract. The DataProvided event is emitted when data is successfully provided by an authorized provider.

- generativeartist.sol contract allows the creation of ERC721 tokens that represent generative art maps based on geographic data of food supply. The mint function can be used to create a new token and assign ownership to a specified address. The getArtworkData and getArtworkAuthor functions can be used to retrieve the data and author of the artwork associated with a specific token ID.

To use this contract, you would first need to deploy it to a blockchain network such as Ethereum. Once deployed, you could interact with the contract using a wallet application that supports ERC721 tokens, such as MetaMask. You would then be able to create new tokens by calling the mint function and passing in the necessary data and author information. These tokens could then be sold or traded on various online marketplaces.

- royalties.sol contract implements the IERC2981 interface, which defines a standard way to retrieve information about royalty payments for a given NFT.

The Royalty struct represents a single recipient and their corresponding percentage of the royalty value. The _royalties mapping stores an array of Royalty structs for each token ID.

The royaltyInfo function retrieves the list of royalty recipients and their corresponding amounts for a given token ID and sale value. It calculates the amounts based on the percentage value stored in the _royalties mapping.

The addRoyalty and removeRoyalty functions can be used to add or remove royalty recipients for a given token ID.

To use this smart contract, you can import the Royalties.sol file into your main contract and create a new instance of the Royalties contract. You can then call the addRoyalty function to add recipients and their corresponding percentage values, and the removeRoyalty function to remove recipients. When the NFT is sold, the royalty amounts will be automatically distributed to the recipients based on their percentage values.

- supplychain.sol contract extends the Royalties contract to handle the distribution of royalties to the data provider and the generative artist for a tokenized generative artwork. The contract includes several features to support the supply chain of the artwork, including the tracking of spending proposals and the execution of approved proposals.

The contract defines the addresses of the data provider and generative artist, as well as the token ID and URI for the artwork. It also defines a struct to represent a spending proposal, which includes the recipient address, the amount of ether requested, and a flag indicating whether the proposal has been approved.

The contract includes a function to add a spending proposal to the array, which can only be called by the data provider or the generative artist. It also includes a function for recipients to approve a spending proposal, and a function to execute an approved proposal.

In addition, the contract overrides the _transfer function to distribute royalties to the data provider and generative artist, and the tokenURI function to return the custom token URI for the artwork.

By incorporating these features into the smart contract, the supply chain for the tokenized generative artwork can be managed more effectively, with clear rules for the distribution of royalties and the allocation of funds for other goods.




