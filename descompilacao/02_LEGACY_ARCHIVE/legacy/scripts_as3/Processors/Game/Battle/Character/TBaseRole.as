package Processors.Game.Battle.Character
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Battle.*;
   import Logics.Battle.model.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Battle.*;
   import Processors.Game.Battle.Effect.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.text.*;
   import ghostcat.util.easing.*;
   
   public class TBaseRole extends TActive
   {
      
      public static const INIT_HpBar_Y:Number = -100;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FInfo:TRoleBattleInfo;
      
      protected var FShowSpEffect:Boolean;
      
      protected var FWaitDie:Boolean;
      
      protected var FHp_Effect:Sprite;
      
      protected var FCurAnger:Number;
      
      protected var FCurHealth:Number;
      
      public function TBaseRole(param1:TUIComponent, param2:TRoleBattleInfo, param3:uint = 0, param4:Boolean = false, param5:int = 0)
      {
         super(param1,param2.RoleId,param3,param4,false,true,param5);
         this.FInfo = param2;
         this.InitBaseRole();
      }
      
      protected function InitBaseRole() : void
      {
         var _loc1_:String = null;
         FIdlePosition = new Vector.<int>(2);
         this.FWaitDie = false;
         if(FHpBar == null)
         {
            FHpBar = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_HP_Bar) as MovieClip;
            addChild(FHpBar);
            this.FHp_Effect = new Sprite();
            FHpBar.addChildAt(this.FHp_Effect,1);
            this.FHp_Effect.graphics.beginFill(16711680,1);
            this.FHp_Effect.graphics.drawRect(0,0,FHpBar.mc_hp.width,FHpBar.mc_hp.height);
            this.FHp_Effect.graphics.endFill();
            this.FHp_Effect.x = FHpBar.mc_hp.x;
            this.FHp_Effect.y = FHpBar.mc_hp.y;
            FHpBar.y = INIT_HpBar_Y;
         }
         if(this.CharacterName != null && this.CharacterName != "")
         {
            _loc1_ = this.CharacterName;
         }
         else
         {
            if(FHero != null)
            {
               _loc1_ = FHero.Name;
            }
            else if(FEnemy != null)
            {
               _loc1_ = FEnemy.Name;
            }
            else if(FNpc != null)
            {
               _loc1_ = FNpc.Name;
            }
            else
            {
               _loc1_ = "";
            }
            this.FInfo.RoleName = _loc1_;
         }
         FHpBar.mc_name.mc_name.tf_name.text = _loc1_;
         FHpBar.mc_name.mc_name.tf_name.textColor = QUALITYCOLOR_INDEX[this.FInfo.Quality];
         this.FShowSpEffect = false;
         this.CurAnger = this.FInfo.CurAnger;
         this.CurHealth = this.FInfo.CurHealth;
         this.CheckDirection();
         this.InitWuXing();
         FHpBar.mc_hp.visible = Boolean(FResourcesType == TYPE_HERO || FResourcesType == TYPE_ENEMY);
         FHpBar.hp_bg.visible = Boolean(FResourcesType == TYPE_HERO || FResourcesType == TYPE_ENEMY);
      }
      
      protected function MoveOut(param1:DisplayObject) : void
      {
         var Remove:Function = null;
         var Tf:DisplayObject = param1;
         Remove = function():void
         {
            if(Boolean(Tf) && Boolean(Tf.parent))
            {
               Tf.parent.removeChild(Tf);
            }
         };
         TweenUtil.to(Tf,1000,{
            "y":Tf.y - 50,
            "onComplete":Remove
         });
      }
      
      protected function DisappearEffect(param1:DisplayObject, param2:uint) : void
      {
         TweenUtil.to(param1,param2,{"alpha":0});
      }
      
      public function get Camp() : int
      {
         return this.FInfo ? this.FInfo.Camp : 0;
      }
      
      public function get Pos() : int
      {
         return this.FInfo ? this.FInfo.Pos : 0;
      }
      
      public function set Pos(param1:int) : void
      {
         this.FInfo.Pos = param1;
      }
      
      public function get CharacterName() : String
      {
         return this.FInfo ? this.FInfo.RoleName : "";
      }
      
      override public function get Id() : int
      {
         return this.FInfo ? this.FInfo.RoleId : 0;
      }
      
      public function get CurHealth() : Number
      {
         return this.FCurHealth;
      }
      
      public function set CurHealth(param1:Number) : void
      {
         this.FHp_Effect.alpha = 1;
         this.FHp_Effect.scaleX = FHpBar.mc_hp.scaleX;
         this.DisappearEffect(this.FHp_Effect,200);
         this.FCurHealth = param1;
         if(this.FCurHealth > this.TotleHealth)
         {
            this.FCurHealth = this.TotleHealth;
         }
         if(this.FCurHealth < 0)
         {
            this.FCurHealth = 0;
         }
         if(FHpBar)
         {
            FHpBar.mc_hp.scaleX = Math.max(Math.min(this.FCurHealth / this.TotleHealth,1),0);
         }
      }
      
      public function get TotleHealth() : Number
      {
         return this.FInfo ? this.FInfo.TotleHealth : 0;
      }
      
      public function set TotleHealth(param1:Number) : void
      {
         this.FInfo.TotleHealth = param1;
      }
      
      public function get CurAnger() : Number
      {
         return this.FCurAnger;
      }
      
      public function set CurAnger(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this.FCurAnger = param1;
         if(this.FCurAnger > 500)
         {
            this.FCurAnger = 500;
         }
         if(this.FShowSpEffect && param1 < this.TotleAnger)
         {
            this.FShowSpEffect = false;
            TEffectControl.RemovePublicEffect(FBgSprite,CONST_BATTLE.Public_Effect_AngerRing);
         }
         if(!this.FShowSpEffect && param1 >= this.TotleAnger)
         {
            this.FShowSpEffect = true;
            TEffectControl.ShowPublicEffect(FBgSprite,CONST_BATTLE.Public_Effect_AngerRing);
         }
      }
      
      public function get TotleAnger() : int
      {
         return this.FInfo ? this.FInfo.TotleAnger : 0;
      }
      
      public function get Level() : int
      {
         return this.FInfo ? this.FInfo.RoleLevel : 0;
      }
      
      public function get SkillID() : int
      {
         return this.FInfo ? this.FInfo.SkillId : 0;
      }
      
      public function get RoleInfo() : TRoleBattleInfo
      {
         return this.FInfo;
      }
      
      public function InitWuXing() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Bitmap = null;
         var _loc3_:Array = [];
         if(this.FInfo == null)
         {
            return;
         }
         FWuxingBmpVec = new Vector.<Bitmap>();
         FWuxingBmp = TPoolBitmap.GetBitmap();
         addChild(FWuxingBmp);
         FWuxingBmpVec.push(FWuxingBmp);
         FWuxingBmp1 = TPoolBitmap.GetBitmap();
         addChild(FWuxingBmp1);
         FWuxingBmpVec.push(FWuxingBmp1);
         _loc2_ = 1;
         while(_loc2_ < CONST_WUXING.ELE_TYPE.length)
         {
            _loc1_ = this.FInfo.ElementBit >> _loc2_ & 1;
            if(_loc1_ == 1)
            {
               _loc3_.push(_loc2_);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < FWuxingBmpVec.length)
         {
            _loc4_ = CONST_WUXING.ELE_TYPE[_loc3_[_loc2_]];
            _loc5_ = FWuxingBmpVec[_loc2_];
            _loc5_.bitmapData = TUtilityReflection.CreateInstance("mc_" + _loc4_);
            _loc2_++;
         }
      }
      
      public function setActive(param1:TRoleBattleInfo) : void
      {
         this.FInfo = param1;
         this.InitBaseRole();
      }
      
      override public function CheckDirection() : void
      {
         if(this.Camp == 0)
         {
            scaleX = Math.abs(scaleX);
         }
         else if(this.Camp == 1)
         {
            scaleX = -Math.abs(scaleX);
         }
         FHpBar.scaleX = scaleX;
         if(FNameTextFiled != null)
         {
            FNameTextFiled.scaleX = scaleX;
         }
         if(FBuffSprite != null)
         {
            FBuffSprite.scaleX = scaleX;
         }
      }
      
      public function ResetBaseRole(param1:TUIComponent, param2:TRoleBattleInfo, param3:uint = 0, param4:Boolean = false) : void
      {
         ResetActive(param1,param2.RoleId,param3,param4,false,true);
         this.FWaitDie = false;
         this.FInfo = param2;
         this.FShowSpEffect = false;
         FHpBar.y = INIT_HpBar_Y;
         TEffectControl.RemoveContainerEffect(this);
         TEffectControl.RemoveContainerPublicEffect(FBgSprite);
         this.InitBaseRole();
      }
      
      override public function Releasing() : void
      {
         super.Releasing();
         this.FInfo = null;
         FWuxingBmp.bitmapData = null;
         FWuxingBmp1.bitmapData = null;
      }
   }
}

