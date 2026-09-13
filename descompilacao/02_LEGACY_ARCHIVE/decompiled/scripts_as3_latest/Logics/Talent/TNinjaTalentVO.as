package Logics.Talent
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TRefreshTalent;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TNinjaTalentVO
   {
      
      public var Identity:int;
      
      public var RefreshId:int;
      
      protected var FOrigionId:int;
      
      protected var FRefreshTalent:TRefreshTalent;
      
      protected var FTalent:int;
      
      public var RefreshStatus:Boolean;
      
      public function TNinjaTalentVO()
      {
         super();
      }
      
      public function get OrigionId() : int
      {
         if(this.RefreshId > 0)
         {
            this.FRefreshTalent = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RefreshTalent,this.RefreshId) as TRefreshTalent;
            this.FOrigionId = this.FRefreshTalent.OrigionId;
         }
         return this.FOrigionId;
      }
      
      public function get Talent() : int
      {
         if(this.RefreshId > 0)
         {
            this.FRefreshTalent = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RefreshTalent,this.RefreshId) as TRefreshTalent;
            this.FTalent = this.FRefreshTalent.Talent;
         }
         return this.FTalent;
      }
   }
}

