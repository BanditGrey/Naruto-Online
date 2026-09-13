package Processors.Game.Lobby.Homeland.Panel
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMarryClass;
   import Logics.DatebaseVO.VO.TRingValue;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIHomeInfo
   {
      
      protected var FMC_Scene:MovieClip;
      
      public function TUIHomeInfo(param1:MovieClip)
      {
         super();
         this.FMC_Scene = param1;
      }
      
      public function UpdateUI() : void
      {
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         if(THomelandModel.selfLand.length == 0)
         {
            return;
         }
         var _loc1_:TMarryClass = null;
         var _loc2_:int = 0;
         var _loc3_:TRingValue = null;
         var _loc4_:int = 0;
         if(THomelandModel.Status == 0)
         {
            _loc1_ = THomelandModel.getMarryVOByExp(THomelandModel.selfHome.charm);
            _loc2_ = _loc1_.AllCharm;
            _loc3_ = THomelandModel.getRingVOByExp(THomelandModel.selfHome.ringId,THomelandModel.selfHome.ringExp);
            _loc4_ = THomelandModel.getRingTotalExp(_loc3_);
            this.FMC_Scene.gotoAndStop(1);
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Change,true);
            this.FMC_Scene.BTN_Change.addEventListener(MouseEvent.CLICK,this.onChangeClick);
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_List,true);
            this.FMC_Scene.BTN_List.addEventListener(MouseEvent.CLICK,this.onListClick);
            this.FMC_Scene.TF_HomeName.text = THomelandModel.selfHome.landName;
            this.FMC_Scene.TF_Host.text = THomelandModel.selfHome.username_0;
            this.FMC_Scene.TF_Hostess.text = THomelandModel.selfHome.username_1;
            this.FMC_Scene.TF_MarryDesc.text = TIllustratedModel.TextFormat(70480001,_loc1_.Name + " (Lv." + _loc1_.Stars + ")");
            this.FMC_Scene.TF_Charm.text = TIllustratedModel.TextFormat(70480002,THomelandModel.selfHome.charm - _loc2_ + "/" + THomelandModel.getNextMarry(_loc1_).NeedCharm);
            this.FMC_Scene.TF_RingCharm.text = TIllustratedModel.TextFormat(70480003,_loc3_.Charm);
            this.FMC_Scene.TF_OpenLand.text = TIllustratedModel.TextFormat(70480005,THomelandModel.selfLand.length + "/" + 30);
            _loc7_ = JSON.parse(_loc1_.Value).addOther;
            _loc8_ = 0;
            while(_loc8_ < 1)
            {
               if(_loc8_ < _loc7_.length)
               {
                  this.FMC_Scene["TF_Attribute_" + _loc8_].text = TIllustratedModel.AttributeFormat(_loc7_[_loc8_].type,_loc7_[_loc8_].value);
               }
               else
               {
                  this.FMC_Scene["TF_Attribute_" + _loc8_].text = "";
               }
               _loc8_++;
            }
         }
         else
         {
            this.FMC_Scene.gotoAndStop(2);
            _loc9_ = THomelandModel.currentHome;
            this.FMC_Scene.TF_HomeName.text = _loc9_.landName;
            this.FMC_Scene.TF_Host.text = _loc9_.host;
            this.FMC_Scene.TF_Hostess.text = _loc9_.hostess;
            _loc1_ = THomelandModel.getMarryVOByExp(_loc9_.charm);
            _loc2_ = _loc1_.AllCharm;
            this.FMC_Scene.TF_MarryDesc.text = TIllustratedModel.TextFormat(70480001,_loc1_.Name + " (Lv." + _loc1_.Stars + ")");
            this.FMC_Scene.TF_Charm.text = TIllustratedModel.TextFormat(70480002,_loc9_.charm - _loc2_ + "/" + THomelandModel.getNextMarry(_loc1_).NeedCharm);
         }
         var _loc5_:String = _loc1_.Picture.toString();
         var _loc6_:int = int(_loc5_.substr(3,2));
         this.FMC_Scene["MC_MarryLevel_iCon"].gotoAndStop(_loc6_ + 1);
      }
      
      private function onChangeClick(param1:MouseEvent) : void
      {
         THomelandModel.homeLand.FChangeName.visible = true;
      }
      
      private function onListClick(param1:MouseEvent) : void
      {
         THomelandModel.homeLand.FMarryList.visible = true;
      }
   }
}

