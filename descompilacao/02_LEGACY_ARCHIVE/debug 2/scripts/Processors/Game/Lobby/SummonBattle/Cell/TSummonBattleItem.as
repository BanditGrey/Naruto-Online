package Processors.Game.Lobby.SummonBattle.Cell
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TAgentStr;
   import Logics.SummonBattle.TSummonBattleData;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TSummonBattleItem
   {
      
      protected var FSummonBit:Bitmap;
      
      protected var FIconflag:Bitmap;
      
      protected var FSelfIcon:Bitmap;
      
      protected var FBTN_Occupy:MovieClip;
      
      public var SummonBattleData:TSummonBattleData;
      
      public var OnClickOccupy:Function;
      
      public function TSummonBattleItem(param1:MovieClip)
      {
         super();
         this.FSummonBit = new Bitmap();
         param1.pos.addChild(this.FSummonBit);
         this.FIconflag = new Bitmap();
         param1.pos.addChild(this.FIconflag);
         this.FSelfIcon = new Bitmap();
         param1.pos.addChild(this.FSelfIcon);
         this.FBTN_Occupy = param1.BTN_Occupy;
         TGameUtil.setButtonMode(this.FBTN_Occupy,true);
         this.FBTN_Occupy.addEventListener(MouseEvent.CLICK,this.OnClickBtnOccupy);
      }
      
      public function UpData(param1:TSummonBattleData) : void
      {
         this.SummonBattleData = param1;
         if(this.SummonBattleData)
         {
            this.FSummonBit.bitmapData = TUtilityReflection.CreateInstance("summon_Img_" + param1.SumonLevel);
            this.FSummonBit.x = -this.FSummonBit.width / 2;
            this.FSummonBit.y = -this.FSummonBit.height;
            if(Boolean(this.AgentStr) && Boolean(this.AgentStr.Pic))
            {
               this.FIconflag.bitmapData = TUtilityReflection.CreateInstance("summon_flag_" + this.AgentStr.Pic);
               this.FIconflag.x = -this.FIconflag.width / 2;
               this.FIconflag.y = -this.FIconflag.height;
            }
            else
            {
               this.FIconflag.bitmapData = null;
            }
            this.FSelfIcon.bitmapData = this.SummonBattleData.IsMyself ? TUtilityReflection.CreateInstance("summon_self_Icon") : null;
            this.FSelfIcon.x = -this.FSelfIcon.width / 2;
            this.FSelfIcon.y = -this.FSelfIcon.height;
         }
      }
      
      protected function get AgentStr() : TAgentStr
      {
         return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AgentStr,this.SummonBattleData.AgentId) as TAgentStr;
      }
      
      protected function OnClickBtnOccupy(param1:MouseEvent) : void
      {
         if(this.OnClickOccupy != null)
         {
            this.OnClickOccupy(this);
         }
      }
   }
}

