package Processors.Game.Lobby.SevenKing
{
   import Foundation.Network.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TSevenHeroArmy;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Resources.Constants.*;
   import Resources.Strings.STRING_SEVENHEROS;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowFightResult extends TUIComponent
   {
      
      protected var Bg_Sp:Shape;
      
      protected var FScene:MovieClip;
      
      protected var FChangeHero:Function;
      
      public function TProcessorWindowFightResult(param1:TUIComponent)
      {
         super(param1);
         this.Bg_Sp = new Shape();
         this.Bg_Sp.graphics.beginFill(0,0.1);
         this.Bg_Sp.graphics.drawRect(0,0,CONST_COMMON.STAGE_Max_Width,CONST_COMMON.STAGE_Max_Height);
         this.Bg_Sp.graphics.endFill();
         addChild(this.Bg_Sp);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SEVENKING.RESOURCESID_CLASSNAME_FightResult) as MovieClip;
         addChild(this.FScene);
         this.FScene.btn_change.addEventListener(MouseEvent.CLICK,this.OnChangeHero);
         this.FScene.btn_goon.addEventListener(MouseEvent.CLICK,this.OnGoOn);
         this.FScene.btn_ok.addEventListener(MouseEvent.CLICK,this.OnCancel);
         TGameUtil.setButtonMode(this.FScene.btn_change,true);
         TGameUtil.setButtonMode(this.FScene.btn_goon,true);
         TGameUtil.setButtonMode(this.FScene.btn_ok,true);
      }
      
      protected function OnChangeHero(param1:MouseEvent) : void
      {
         Visible = false;
         if(this.FChangeHero != null)
         {
            this.FChangeHero(this);
         }
      }
      
      protected function OnGoOn(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SevenKing_FightReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(0);
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnCancel(param1:MouseEvent) : void
      {
         Visible = false;
      }
      
      public function get ChangeHero() : Function
      {
         return this.FChangeHero;
      }
      
      public function set ChangeHero(param1:Function) : void
      {
         this.FChangeHero = param1;
      }
      
      public function SetResult(param1:Boolean, param2:Boolean, param3:TSevenHeroArmy) : void
      {
         var _loc4_:TSystemLanguage = null;
         var _loc5_:String = null;
         var _loc6_:TSevenHeroArmy = null;
         var _loc7_:uint = 0;
         _loc7_ = param3.Identifier + 1;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SevenHeroArmy,_loc7_) as TSevenHeroArmy;
         if(param1)
         {
            this.FScene.gotoAndStop(2);
         }
         else
         {
            this.FScene.gotoAndStop(1);
         }
         if(param2)
         {
            this.FScene.btn_change.visible = true;
            this.FScene.btn_goon.visible = true;
            this.FScene.btn_ok.visible = false;
         }
         else
         {
            this.FScene.btn_change.visible = false;
            this.FScene.btn_goon.visible = false;
            this.FScene.btn_ok.visible = true;
         }
         if(param2)
         {
            if(param1)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.SEVENHERO_SINGLE_WIN) as TSystemLanguage;
               _loc5_ = _loc4_.Desc;
               this.FScene.tf_info.text = _loc5_;
            }
            else
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.SEVENHERO_SINGLE_LOSE) as TSystemLanguage;
               _loc5_ = _loc4_.Desc;
               this.FScene.tf_info.text = _loc5_;
            }
         }
         else if(param1)
         {
            if(param3.SortNumber != 3)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.SEVENHERO_TEAM_WIN) as TSystemLanguage;
               _loc5_ = _loc4_.Desc;
               this.FScene.tf_info.text = TUtilityString.Format(_loc5_,_loc6_.Name);
            }
            else
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.SEVENHERO_TEAM_WIN_BOSS) as TSystemLanguage;
               _loc5_ = _loc4_.Desc;
               if(_loc6_ == null)
               {
                  this.FScene.tf_info.text = STRING_SEVENHEROS.STRING_DefeatAll;
               }
               else
               {
                  this.FScene.tf_info.text = TUtilityString.Format(_loc5_,_loc6_.Name);
               }
            }
         }
         else
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.SEVENHERO_TEAM_LOSE) as TSystemLanguage;
            _loc5_ = _loc4_.Desc;
            this.FScene.tf_info.text = _loc5_;
         }
      }
   }
}

