package Logics.Recruit
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TDrawNinja;
   import Logics.DatebaseVO.VO.TDrawNinjaArchive;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TRecruit
   {
      
      public var heroId:int;
      
      public var activate:int;
      
      public var starNum:int;
      
      public var count:int;
      
      public var isDrawed:Boolean;
      
      public var name:String;
      
      public var DrawNinjaArchive:TDrawNinjaArchive;
      
      protected var FDrawNinja:TDrawNinja;
      
      protected var FDrawNinjaBins:TBins;
      
      public function TRecruit()
      {
         super();
         this.FDrawNinjaBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DrawNinja);
      }
      
      public function get DrawNinja() : TDrawNinja
      {
         this.FDrawNinja = this.FDrawNinjaBins.GetDatebaseByValue("Ninjaid",this.heroId) as TDrawNinja;
         return this.FDrawNinja;
      }
   }
}

