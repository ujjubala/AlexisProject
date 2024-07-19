import { LightningElement } from 'lwc';

export default class FetchApiDemo extends LightningElement
{
  imgURL;
  endPoint = 'https://some-random-api.ml/animal/cat';
 /* async getImageHandler()
  {
    const response = await fetch(this.endPoint, {method : 'GET'});
    const res      = await response.json();
    this.imgUrl    = res.image; 
  }*/
getImageHandler()
{
fetch(this.endPoint, {method : 'GET'})
.then(res => res.json())
.then(json => {
    console.log(json);
    this.imgURL = "https://i.imgur.com/fClJeO6.jpg"; 
});
}
}
