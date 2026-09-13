package Logics.Emblem
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TEmblem;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TEmblemData
   {
      
      public var EmblemId:int;
      
      public var Type:int;
      
      public var Name:String;
      
      public var Unlock:int;
      
      public var Tips:String;
      
      public var ErrorText:String;
      
      public var EmblemConfig:TEmblem;
      
      public function TEmblemData(param1:int)
      {
         super();
         this.EmblemId = param1;
         if(this.EmblemConfig == null)
         {
            this.EmblemConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,this.EmblemId) as TEmblem;
            this.Tips = this.EmblemConfig.Tips;
            this.ErrorText = this.EmblemConfig.Error;
         }
      }
   }
}

