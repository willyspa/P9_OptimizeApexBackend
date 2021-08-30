public without sharing class MyTeamOrdersController {
    public decimal SumOforders{
        get{
            Decimal totalSOQL;
            AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
            totalSOQL = (decimal)groupedResults.get('total');
			return totalSOQL;

        }
        set;
    }
}