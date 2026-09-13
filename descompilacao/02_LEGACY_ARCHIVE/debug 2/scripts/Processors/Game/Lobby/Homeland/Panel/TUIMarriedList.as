package Processors.Game.Lobby.Homeland.Panel
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMarryClass;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   
   public class TUIMarriedList
   {
      
      protected var FSelected:int = 1;
      
      protected var FCurrent:int = 0;
      
      protected var FStart:int = 0;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMask:Shape = null;
      
      public function TUIMarriedList(param1:MovieClip)
      {
         super();
         this.FMC_Scene = param1;
         this.FMC_Scene.parent.setChildIndex(this.FMC_Scene,this.FMC_Scene.parent.numChildren - 1);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_ArrorLeft,true);
         this.FMC_Scene.MC_ArrorLeft.addEventListener(MouseEvent.CLICK,this.OnArrorLeftClick);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_ArrorRight,true);
         this.FMC_Scene.MC_ArrorRight.addEventListener(MouseEvent.CLICK,this.OnArrorRightClick);
         this.FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,THomelandModel.homeLand.ButtonHelpOnOver);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,THomelandModel.homeLand.ButtonHelpOnOut);
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            this.FMC_Scene["MC_MarryLevel_" + _loc2_].addEventListener(MouseEvent.CLICK,this.OnMarryLevelClick);
            _loc2_++;
         }
         this.FMask = new Shape();
         this.FMask.graphics.beginFill(0,0.8);
         this.FMask.graphics.drawRect(-this.FMC_Scene.x,-this.FMC_Scene.y,1250,650);
         this.FMask.graphics.endFill();
         this.FMC_Scene.addChildAt(this.FMask,0);
      }
      
      public function UpdateUI() : void
      {
         var _loc1_:TMarryClass = THomelandModel.getMarryVOByExp(THomelandModel.selfHome.charm) as TMarryClass;
         var _loc2_:String = _loc1_.Picture.toString();
         this.FCurrent = int(_loc2_.substr(3,2));
         this.Start = this.FCurrent;
         this.UpdateInfo(this.FCurrent);
      }
      
      public function UpdateInfo(param1:int) : void
      {
         var _loc4_:TMarryClass = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         this.FSelected = param1 + 1;
         this.FMC_Scene["MC_MarryLevel_iCon"].gotoAndStop(this.FSelected);
         var _loc2_:int = THomelandModel.MarryClass.Count;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = THomelandModel.MarryClass.GetDatebaseByIndex(_loc3_) as TMarryClass;
            _loc5_ = _loc4_.Picture.toString();
            _loc6_ = int(_loc5_.substr(3,2));
            if(_loc6_ == param1)
            {
               break;
            }
            _loc3_++;
         }
         if(_loc4_)
         {
            _loc7_ = _loc4_.Desc.replace(/\\n/g,"\n");
            _loc7_ = _loc7_.replace(/%n/g,"\n");
            this.FMC_Scene["TF_Desc"].text = _loc7_;
            this.FMC_Scene["TF_Pland"].text = TIllustratedModel.TextFormat(70480017,this.getMarryLand(_loc4_));
            this.FMC_Scene["TF_Pick"].text = TIllustratedModel.TextFormat(70480018,this.getMarryFailRate(_loc4_));
            _loc8_ = JSON.parse(_loc4_.Value).addOther;
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               if(_loc3_ < _loc8_.length)
               {
                  this.FMC_Scene["TF_Attribute_" + _loc3_].text = TIllustratedModel.AttributeFormat(_loc8_[_loc3_].type,_loc8_[_loc3_].value);
               }
               else
               {
                  this.FMC_Scene["TF_Attribute_" + _loc3_].text = "";
               }
               _loc3_++;
            }
         }
      }
      
      private function getMarryLand(param1:TMarryClass) : String
      {
         var _loc5_:TMarryClass = null;
         var _loc2_:String = "";
         var _loc3_:int = THomelandModel.MarryClass.Count;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = THomelandModel.MarryClass.GetDatebaseByIndex(_loc4_) as TMarryClass;
            if(_loc5_.Name == param1.Name)
            {
               if(_loc2_.length == 0)
               {
                  _loc2_ += _loc5_.LandNum + "";
               }
               else
               {
                  _loc2_ += "/" + _loc5_.LandNum + "";
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function getMarryFailRate(param1:TMarryClass) : String
      {
         var _loc5_:TMarryClass = null;
         var _loc2_:String = "";
         var _loc3_:int = THomelandModel.MarryClass.Count;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = THomelandModel.MarryClass.GetDatebaseByIndex(_loc4_) as TMarryClass;
            if(_loc5_.Name == param1.Name)
            {
               if(_loc2_.length == 0)
               {
                  _loc2_ += _loc5_.FailRate + "";
               }
               else
               {
                  _loc2_ += "/" + _loc5_.FailRate + "";
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function OnArrorLeftClick(param1:MouseEvent) : void
      {
         --this.Start;
      }
      
      private function OnArrorRightClick(param1:MouseEvent) : void
      {
         ++this.Start;
      }
      
      private function OnMarryLevelClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this.UpdateInfo(_loc2_.currentFrame - 1);
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            this.FMC_Scene["MC_MarryLevel_" + _loc3_].MC_Selected.visible = this.FMC_Scene["MC_MarryLevel_" + _loc3_].currentFrame == this.FSelected;
            _loc3_++;
         }
      }
      
      private function OnWindowClose(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function get Start() : int
      {
         return this.FStart;
      }
      
      public function set Start(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         param1 = param1 < 0 ? 0 : param1;
         param1 = param1 > 16 ? 16 : param1;
         this.FStart = param1;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = this.FStart + _loc2_;
            this.FMC_Scene["MC_MarryLevel_" + _loc2_].gotoAndStop(_loc3_ + 1);
            _loc4_ = this.FMC_Scene["MC_MarryLevel_" + _loc2_]["Cell"];
            _loc4_.gotoAndStop(_loc3_ <= this.FCurrent ? 1 : 2);
            if(_loc3_ == this.FCurrent)
            {
               _loc4_["MC_Label"].visible = true;
               _loc4_["MC_Label"].gotoAndStop(1);
            }
            else if(_loc3_ == this.FCurrent + 1)
            {
               _loc4_["MC_Label"].visible = true;
               _loc4_["MC_Label"].gotoAndStop(2);
            }
            else
            {
               _loc4_["MC_Label"].visible = false;
            }
            this.FMC_Scene["MC_MarryLevel_" + _loc2_].MC_Selected.visible = this.FMC_Scene["MC_MarryLevel_" + _loc2_].currentFrame == this.FSelected;
            _loc2_++;
         }
      }
      
      public function get visible() : Boolean
      {
         return this.FMC_Scene.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
         if(this.FMC_Scene.visible)
         {
            this.UpdateUI();
         }
      }
   }
}

