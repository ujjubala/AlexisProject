import { LightningElement,track } from 'lwc';
import getExchangeRate from '@salesforce/apex/verifyCurrency.getExchangeRate';
export default class CustomPicklistCompo extends LightningElement 
{
    fromCurrency;
    toCurrency;
    amount;
    convertedAmount;
    
    //apiUrl = 'https://anyapi.io/api/v1/exchange/convert?base=USD&to=INR&amount=10000&apiKey=hddfk9if6io0php6th5e9o8en4r79eoiggml2j06flcouq7bko8lfao';
    //endPoint = 'https://anyapi.io/api/v1/exchange/convert?';
    //apiKey   = 'hddfk9if6io0php6th5e9o8en4r79eoiggml2j06flcouq7bko8lfao';
    currencyOptions = [
            { label: 'USD', value: 'USD' },
            { label: 'INR', value: 'INR' },
            { label: 'GBP', value: 'GBP' },
            { label: 'JPY', value: 'JPY' },
            { label: 'AUD', value: 'AUD' },
           
        ];
    
        handleFromCurrencyChange(event) {
            this.fromCurrency = event.detail.value;
        }
        handleAmountChange(event) {
            this.amount = event.target.value;
           
        }
    
        handleToCurrencyChange(event) {
            this.toCurrency = event.detail.value;
            getExchangeRate({'currencyFrom' : this.fromCurrency, 'currencyTo' : this.toCurrency, 'amount' : this.amount})
            .then(result=>{
                console.log('Success....' +JSON.stringify(result));
                this.convertedAmount = result;
            })
            .catch(error=>{
                console.log('Something went wrong..' +JSON.stringify(error));
            })
        }
    
       
    }    
    
