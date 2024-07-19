import { LightningElement, track, wire } from 'lwc';
import getCases from '@salesforce/apex/CaseController.getCases';
import getCaseCount from '@salesforce/apex/CaseController.getCaseCount';


export default class PaginationDemo extends LightningElement 
{
    @track cases = [];
    @track columns = [
        { label: 'Case Number', fieldName: 'CaseNumber' },
        { label: 'Priority', fieldName: 'Priority' },
        { label: 'Status', fieldName: 'Status' },
        { label : 'Origin', fieldName: 'Origin',editable : true }
    ];
    @track pageSize = 5;
    @track currentPage = 1;
    @track totalCases = 0;
    @track totalPages = 0;

    @wire(getCaseCount)
    wiredCaseCount({ error, data }) {
        if (data) {
            this.totalCases = data;
            this.totalPages = Math.ceil(this.totalCases / this.pageSize);
        } else if (error) {
            console.error(error);
        }
    }

    connectedCallback() {
        this.loadCases();
    }

    loadCases() {
        getCases({ pageNumber: this.currentPage, pageSize: this.pageSize })
            .then(result => {
                this.cases = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    get isFirstPage() {
        return this.currentPage === 1;
    }

    get isLastPage() {
        return this.currentPage >= this.totalPages;
    }

    handlePrevious() {
        if (!this.isFirstPage) {
            this.currentPage -= 1;
            this.loadCases();
        }
    }

    handleNext() {
        if (!this.isLastPage) {
            this.currentPage += 1;
            this.loadCases();
        }
    }
}

